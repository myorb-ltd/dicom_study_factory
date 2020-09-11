# frozen_string_literal: true

require 'faker'

module DicomStudyFactory
  # Create a fake patient
  class Patient
    attr_reader :dob

    def initialize
      @id = Faker::Number.unique.number(digits: 10).to_s
      @dob = Faker::Date.birthday(min_age: 0, max_age: 99)
      @sex = %w[M F].sample
      last_name = Faker::Name.unique.last_name
      first_name = @sex=='M' ? Faker::Name.male_first_name : Faker::Name.female_first_name
      @name = first_name + ' ' + last_name
    end

    def tags
      {
        '0010' => name,
        '0020' => @id,
        '0030' => dob_tag,
        '0040' => @sex,
        '1010' => age
      }
    end

    def name
      "#{@name.upcase.gsub(' ', '^')}#{'^' * rand(3)}"
    end

    def dob_tag
      dob.strftime('%Y%m%d')
    end

    def age
      today = Date.today
      years = today.year - @dob.year
      years -= 1 if (today.month * 100 + today.day) < (@dob.month * 100 + @dob.day)
      "0#{years}Y"
    end

    def update_tags(image)
      tags.each_pair do |tag, value|
        image.add_element("0010,#{tag}", value)
      end
    end
  end
end
