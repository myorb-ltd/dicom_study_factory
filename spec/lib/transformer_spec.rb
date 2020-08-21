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

describe DicomStudyFactory::Transformer do
  describe '#files' do
    let(:source_dir) { 'tmp/source' }
    after { FileUtils.rm_r source_dir }
    context 'by default are empty' do
      it { expect(subject.files).to be_empty }
      it { expect(subject.output_files).to be_empty }
    end
    context 'with source files' do
      describe '.dcm files' do
        let(:support_dir) { 'spec/support/dicoms' }
        before do
          FileUtils.cp_r support_dir, described_class::SOURCE_DIR
        end
        it { expect(subject.files).not_to be_empty }
      end
    end
  end
end
