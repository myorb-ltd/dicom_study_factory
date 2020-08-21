# frozen_string_literal: true

require 'fileutils'
module DicomStudyFactory
  # Transforme gets all the .dcm files in one directory
  # and apply a factory data to populate the dicom
  # with tags
  class Transformer
    SOURCE_DIR = 'tmp/source'
    OUTPUT_DIR = 'tmp/output'
    def initialize
      FileUtils.mkdir_p(SOURCE_DIR) unless Dir.exist? SOURCE_DIR
      FileUtils.mkdir_p(OUTPUT_DIR) unless Dir.exist? OUTPUT_DIR
    end

    def files
      Dir.glob(File.join(SOURCE_DIR, '**/*.dcm'))
    end

    def output_files
      Dir.glob(File.join(OUTPUT_DIR, '**/*.dcm'))
    end
  end
end
