# frozen_string_literal: true

require 'fileutils'
module DicomStudyFactory
  # Transforme gets all the .dcm files in one directory
  # and apply a factory data to populate the dicom
  # with tags
  class Transformer
    attr_accessor :source_dir, :output_dir, :patients_studies, :studies

    SOURCE_DIR = 'tmp/source'
    OUTPUT_DIR = 'tmp/output'

    def initialize(source_dir: SOURCE_DIR, output_dir: OUTPUT_DIR)
      @source_dir = source_dir
      @output_dir = output_dir
      FileUtils.mkdir_p(source_dir) unless Dir.exist? source_dir
      FileUtils.rm_rf(output_dir) if Dir.exist? output_dir
      FileUtils.mkdir_p(output_dir)
      @patients_studies = {}
      @studies = []
    end

    def files
      Dir.glob(File.join(source_dir, '**/*.dcm'))
    end

    def output_files
      Dir.glob(File.join(output_dir, '**/*.dcm'))
    end

    def fill_tags
      group_by_patient_and_study
      patients_studies.each_value do |studies|
        patient, patient_dir = patient_prepare
        studies.each_pair do |study_uid, dcms|
          study_prepare(study_uid, patient_dir, patient.dob)
          dcms.each_with_index { |dcm, index| image_fill(patient, dcm, index) }
          extra_data = { study_dir: @study_dir, dicoms: dcms.count }
          @studies << patient.tags.merge(@study.tags, extra_data)
        end
      end
    end

    def write_csv
      headers = @studies.first.keys
      CSV.open(File.join(output_dir, 'studies.csv'), 'wb') do |csv|
        csv << headers
        @studies.each do |st|
          csv << st.values
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

    def study_prepare(study_uid, patient_dir, patient_dob)
      @study = Study.new patient_dob
      @study_dir = File.join(patient_dir, study_uid)
      FileUtils.mkdir_p(@study_dir) unless Dir.exist?(@study_dir)
    end

    def image_fill(patient, dcm, index)
      image = Image.new(dcm)
      patient.update_tags(image)
      @study.update_tags(image)
      output_image = File.join(@study_dir, "#{index}.dcm")
      image.dcm.write(output_image)
    rescue StandardError => e
      puts e.message
    end

    def group_by_patient_and_study
      files.each do |dcm_file|
        image = Image.new(dcm_file)
        study_instance_uid = image.dcm.value('0020,000d')
        add_patient_study(image.dcm.patients_name.value, study_instance_uid, dcm_file)
      end
    end

    def add_patient_study(patient_name, study_instance_uid, dcm)
      patients_studies[patient_name] ||= {}
      patients_studies[patient_name][study_instance_uid] ||= []
      patients_studies[patient_name][study_instance_uid] << dcm
    end
  end
end
