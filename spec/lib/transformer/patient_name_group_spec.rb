# frozen_string_literal: true

describe DicomStudyFactory::Transformer do
  let(:source_dir) { 'spec/support/dicoms/education' }
  describe 'by_patients_name' do
    subject { described_class.new source_dir: source_dir }
    it { expect(Dir.exist?(source_dir)).to eq true }
    it { expect(subject.files.count).to eq 14 }
    it { expect(subject.by_patients_name.keys.count).to eq 3 }
    it { expect(subject.by_patients_name.values.flatten.count).to eq 14 }
  end
end
