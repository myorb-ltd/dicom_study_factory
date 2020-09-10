# frozen_string_literal: true

describe DicomStudyFactory::Transformer do
  let(:source_dir) { 'spec/support/dicoms/education' }
  subject { described_class.new source_dir: source_dir }
  describe '#group_by_patient_and_study' do
    before { subject.send(:group_by_patient_and_study) }
    it { expect(Dir.exist?(source_dir)).to eq true }
    it { expect(subject.files.count).to eq 14 }
    it { expect(subject.patients_studies.keys.count).to eq 3 }
    it { expect(subject.studies.count).to eq 0 }
  end
  describe '#fill_tags' do
    before { subject.fill_tags }
    let(:image) { DicomStudyFactory::Image.new subject.output_files.first }
    let(:csv) { CSV.read(File.join(subject.output_dir, 'studies.csv')) }
    it { expect(image.patient_tags_hash.values).not_to include nil }
    it { expect(image.study_tags_hash.values).not_to include nil }
    it { expect(image.study_id_tags_hash.values).not_to include nil }
    it { expect(subject.studies.count).to eq 3 }
    it do
      subject.write_csv
      expect(csv.count).to eq 4
    end
  end
end
