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
      FileUtils.rm_rf(output_dir) if Dir.exist? output_dir
      FileUtils.mkdir_p(output_dir)
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

    def fill_patient_tags
      by_patients_name.each_value do |dcms|
        patient, patient_dir = patient_prepare
        dcms.each_with_index do |dcm, index|
          image_populate_with_patient(patient, patient_dir, dcm, index)
        end
      end
    end

    private

    def patient_prepare
      patient = Patient.new
      patient_dir = File.join(output_dir, patient.name)
      FileUtils.mkdir_p(patient_dir)
      [patient, patient_dir]
    end

    def image_populate_with_patient(patient, patient_dir, dcm, index)
      image = Image.new(dcm)
      patient.tags.each_pair do |tag, value|
        image.dcm["0010,#{tag}"].value = value
        image.dcm.write(File.join(patient_dir, "#{index}.dcm"))
      end
    rescue => e
      puts e.message
    end

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
