require 'journey'

describe Journey do

  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  subject(:journey) { Journey.new(entry_station: entry_station, exit_station: exit_station)}

  it 'shows an entry station' do
    expect(subject.entry_station).to eq entry_station
  end

  it 'shows an exit station' do
    expect(subject.exit_station).to eq exit_station
  end

  it 'can check if a journey is complete' do
    expect(subject).to be_complete
  end

  context 'when journey is not complete' do
    let (:incomplete_journey) { Journey.new(entry_station: nil, exit_station: exit_station)}
    it 'can check if a journey is not complete' do
      expect(incomplete_journey).not_to be_complete
    end
  end

end