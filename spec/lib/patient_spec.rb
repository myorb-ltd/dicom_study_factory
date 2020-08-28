# frozen_string_literal: true

describe DicomStudyFactory::Patient do
  let(:tags) { subject.tags }
  let(:name) { tags['0010'] }
  let(:dob) { Date.parse(tags['0030']) }
  let(:years_from_dob) { Date.today.year - dob.year }
  it 'has a correct name' do
    expect(name).to include '^'
    expect(name.size).to be > 1
  end
  it { expect(Integer(tags['0020'])).to be_a Integer }
  it { expect(dob).to be_a Date }
  it { expect(tags['0040']).to match 'M|F' }
  it { expect(tags['1010']).to start_with '0' }
  it { expect(tags['1010']).to end_with 'Y' }
  it { expect(tags['1010'].size).to eq 4 }
  it { expect(tags['1010'][1..2].to_i).to be <= years_from_dob }
end
