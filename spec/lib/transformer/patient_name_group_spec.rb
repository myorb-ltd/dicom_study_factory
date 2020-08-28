# frozen_string_literal: true

describe DicomStudyFactory::Transformer do
  let(:source_dir) { 'spec/support/dicoms/education' }
  subject { described_class.new source_dir: source_dir }
  describe '#by_patients_name' do
    it { expect(Dir.exist?(source_dir)).to eq true }
    it { expect(subject.files.count).to eq 14 }
    it { expect(subject.by_patients_name.keys.count).to eq 3 }
    it { expect(subject.by_patients_name.values.flatten.count).to eq 14 }
  end
  describe '#fill_patient_tags' do
    before { subject.fill_patient_tags }
    let(:image) { DicomStudyFactory::Image.new subject.output_files.first }
    it { expect(image.patient_tags_hash.values).not_to include nil }
  end
end
