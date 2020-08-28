# frozen_string_literal: true

require 'faker'

module DicomStudyFactory
  # Create a fake patient
  class Patient
    def initialize
      @name = Faker::Name.unique.name
      @id = Faker::Number.unique.number(digits: 10).to_s
      @dob = Faker::Date.birthday(min_age: 0, max_age: 99)
      @sex = %w[M F].sample
    end

    def tags
      {
        '0010' => name,
        '0020' => @id,
        '0030' => dob,
        '0040' => @sex,
        '1010' => age
      }
    end

    def name
      "#{@name.upcase.gsub(' ', '^')}#{'^' * rand(3)}"
    end

    def dob
      @dob.strftime('%Y%m%d')
    end

    def age
      today = Date.today
      years = today.year - @dob.year
      years -= 1 if (today.month * 100 + today.day) < (@dob.month * 100 + @dob.day)
      "0#{years}Y"
    end
  end
end
