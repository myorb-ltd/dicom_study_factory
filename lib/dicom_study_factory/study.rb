# frozen_string_literal: true

require 'faker'

module DicomStudyFactory
  # Create a fake Study
  class Study
    def initialize(patient_dob)
      @patient_dob = patient_dob
      @date = Faker::Time.between_dates(from: @patient_dob, to: (Date.today - 1), period: :all)
      @accession_number = accession_number
      @institution_name = institution_name
      @study_id = study_id
      @referring_physician_name = name
      @physician_reading_study_name = name
    end

    def tags
      {
        '0020' => date,
        '0030' => time,
        '0050' => @accession_number,
        '0080' => @institution_name,
        '0090' => @referring_physician_name,
        '1060' => @physician_reading_study_name
      }
    end

    def name
      n = Faker::Name.name
      "#{n.upcase.gsub(' ', '^')}#{'^' * rand(3)}"
    end

    def date
      @date.strftime('%Y%m%d')
    end

    def time
      @date.strftime('%H%M%S')
    end

    def accession_number
      Faker::Number.unique.number(digits: 16).to_s
    end

    def study_id
      Faker::Number.unique.number(digits: 20).to_s
    end

    def institution_name
      Faker::Company.name
    end

    def update_tags(image)
      tags.each_pair do |tag, value|
        image.add_element("0008,#{tag}", value)
      end
      image.add_element('0020,0010', @study_id)
    end
  end
end
