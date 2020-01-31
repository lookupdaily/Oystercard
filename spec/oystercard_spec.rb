require 'oystercard'
describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey, entry_station: entry_station, exit_station: exit_station }
  let(:journey_class_double) { double :journey_class, new: journey}
  it "new card should have a balance of zero" do
    expect(subject.balance).to eq 10
  end

  it { is_expected.to respond_to(:balance) }

  describe '#top_up' do
    it { expect(subject).to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error when the limit is exceeded' do
      maximum_balance = Oystercard::Limit
      subject.top_up(80)
      expect{subject.top_up 1 }.to raise_error 'Top up limit exceeded'
    end
  end

  describe '#touch_in("")' do
    # it 'should change status to true' do
    #   expect{ subject.touch_in(entry_station) }.to change{ subject.in_journey? }.to true
    # end

    it 'Should raise an error is below the minimnum balance' do
      oystercard = Oystercard.new(0)
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Balance too low"
    end

    # it 'should return the entry station' do
    #   subject.touch_in(entry_station)
    #   expect(subject.entry_station).to eq entry_station
    # end
  end

  describe '#touch_out' do
    # it 'should make in_journey to return false' do
    #   subject.touch_out(exit_station)
    #   expect(subject.in_journey?).to eq false
    # end

    it 'should deduct the Minimum_fare from balance' do
      subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station) }.to change{ subject.balance }.by -(Oystercard::Minimum_fare)
    end
  end
  describe '#journey_history' do
    it 'Return an empty list for history_journey' do
      expect(subject.journey_history).to eq ([])
    end

    it 'should change the count by 1 at touch_out' do
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.journey_history.count }.by 1
    end

    it 'should include entry and exit stations' do
      card = Oystercard.new(10, journey_class_double)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey_history).to include(journey_class_double)
    end

  end

end
