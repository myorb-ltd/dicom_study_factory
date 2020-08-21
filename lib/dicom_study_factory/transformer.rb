require 'fileutils'
module DicomStudyFactory
  class Transformer
    SOURCE_DIR = 'tmp/source'.freeze
    OUTPUT_DIR = 'tmp/output'.freeze
    def initialize
      FileUtils.mkdir_p(SOURCE_DIR) unless Dir.exist? SOURCE_DIR
      FileUtils.mkdir_p(OUTPUT_DIR) unless Dir.exist? OUTPUT_DIR
    end
  end
end
