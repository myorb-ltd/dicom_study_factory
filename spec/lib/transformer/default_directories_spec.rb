# frozen_string_literal: true

describe DicomStudyFactory::Transformer do
  let(:source_dir) { 'tmp/source' }
  let(:output_dir) { 'tmp/output' }
  describe 'default directories' do
    before { described_class.new }
    it { expect(described_class::SOURCE_DIR).to eq source_dir }
    it { expect(described_class::OUTPUT_DIR).to eq output_dir }
    it { expect(Dir.exist?(source_dir)).to eq true }
    it { expect(Dir.exist?(output_dir)).to eq true }
  end
end
