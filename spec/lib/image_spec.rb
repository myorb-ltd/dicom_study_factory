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
  end
  it '#tags' do
    expect(subject.tags.count).to eq 3673
    expect(subject.tags['0002,0000']).to eq({ vr: 'UL', name: 'File Meta Information Group Length' })
  end
end
