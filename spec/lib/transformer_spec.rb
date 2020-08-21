# frozen_string_literal: true

describe DicomStudyFactory::Transformer do
  describe 'default directories' do
    before { described_class.new }
    let(:source_dir) { 'tmp/source' }
    let(:output_dir) { 'tmp/output' }
    it { expect(described_class::SOURCE_DIR).to eq source_dir }
    it { expect(described_class::OUTPUT_DIR).to eq output_dir }
    it { expect(Dir.exist?(source_dir)).to eq true }
    it { expect(Dir.exist?(output_dir)).to eq true }
  end
  describe '#files' do
    let(:files) { subject.files }
    let(:output_files) { subject.output_files }
    context 'by default are empty' do
      it { expect(files).to be_empty }
      it { expect(output_files).to be_empty }
    end
  end
end
