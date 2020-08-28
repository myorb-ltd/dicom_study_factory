# frozen_string_literal: true

describe DicomStudyFactory::Image do
  let(:file_name) { '1.3.6.1.4.1.5962.99.1.2280943358.716200484.1363785608958.60.0.dcm' }
  let(:path) { 'spec/support/dicoms' }
  let(:file) { File.join(path, file_name) }
  subject { described_class.new file }
  it 'has read the basic data' do
    expect(subject.dcm.patients_name.value).to match 'Case1'
    expect(subject.dcm.patients_name.vr).to match 'PN'
    expect(subject.dcm.patients_name.tag).to match '0010,0010'
    expect(subject.dcm.patients_name.name).to match "Patient's Name"
    expect(subject.dcm.modality.value).to match 'MG'
    expect(subject.dcm.value('0008,1060')).to eq nil
  end
  it 'has tags' do
    expect(subject.tags.count).to eq 3673
    expect(subject.tags['0002,0000']).to eq({ vr: 'UL', name: 'File Meta Information Group Length' })
  end
  it { expect(subject.patient_tags.count).to eq 68 }
  describe 'kingston tags' do
    let(:file_name) { 's2.dcm' }
    it { expect(File.exist?(file)).to eq true }
    it { expect(subject.present_patient_tags.count).to eq 5 }
    it { expect(subject.patient_tags_hash.count).to eq 5 }
    it { expect(subject.study_tags_hash.count).to eq 8 }
    it { expect(subject.study_id_tags_hash.count).to eq 2 }
  end
end
