# frozen_string_literal: true

require 'fileutils'
module DicomStudyFactory
  # Transforme gets all the .dcm files in one directory
  # and apply a factory data to populate the dicom
  # with tags
  class Transformer
    attr_accessor :source_dir, :output_dir

    SOURCE_DIR = 'tmp/source'
    OUTPUT_DIR = 'tmp/output'

    def initialize(source_dir: SOURCE_DIR, output_dir: OUTPUT_DIR)
      @source_dir = source_dir
      @output_dir = output_dir
      FileUtils.mkdir_p(source_dir) unless Dir.exist? source_dir
      FileUtils.mkdir_p(output_dir) unless Dir.exist? output_dir
    end

    def files
      Dir.glob(File.join(source_dir, '**/*.dcm'))
    end

    def output_files
      Dir.glob(File.join(output_dir, '**/*.dcm'))
    end

    def by_patients_name
      @by_patients_name ||= patients_name_files_array
    end

    private

    def patients_name_files_array
      by_patient = {}
      files.each do |dcm|
        image = Image.new(dcm)
        by_patient[image.dcm.patients_name.value] ||= []
        by_patient[image.dcm.patients_name.value] << dcm
      end
      by_patient
    end
  end
end
