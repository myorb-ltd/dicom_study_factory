# frozen_string_literal: true

describe DicomStudyFactory::Image do
  let(:file_name) { '1.3.6.1.4.1.5962.99.1.2280943358.716200484.1363785608958.60.0.dcm' }
  let(:path) { 'spec/support/dicoms' }
  let(:file) { File.join(path, file_name) }
  subject { described_class.new file }
  it 'has tags' do
    expect(subject.tags.count).to eq 3673
    expect(subject.tags['0002,0000']).to eq({ vr: 'UL', name: 'File Meta Information Group Length' })
  end
  it { expect(subject.patient_tags.count).to eq 68 }
  describe 'as all required tags names' do
    let(:patient) { DicomStudyFactory::Patient.new }
    let(:study) { DicomStudyFactory::Study.new patient.dob }
    before do
      patient.update_tags(subject)
      study.update_tags(subject)
    end
    it do
      expect(subject.all_required_tags_names.count).to eq 15
      expect(subject.all_required_tags.compact.count).to eq 15
    end
  end
end
