# frozen_string_literal: true

require 'dicom'
require 'csv'

module DicomStudyFactory
  # It's the dicom object
  # reading with a .dcm file
  class Image
    include DICOM

    class << self
      def csv
        CSV.read('spec/support/dicom_tags.csv', col_sep: ';', headers: true)
      end

      def tags
        @@tags ||= csv.map { |row| [row['Tag'], { vr: row['VR'], name: row['Name'] }] }.to_h
      end
    end

    attr_accessor :dcm

    def initialize(file)
      @dcm = DObject.read(file)
    end

    def tags
      Image.tags
    end
  end
end
