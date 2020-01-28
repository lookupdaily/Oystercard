require 'oystercard'
describe Oystercard do
  let(:station) { double :station }
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

  describe '#status' do
    it 'should return true or false' do
      expect(subject.status).to eq false
    end
  end

  describe '#touch_in("")' do
    it 'should change status to true' do
      expect{ subject.touch_in(station) }.to change{ subject.status }.to true
    end

    it 'Should raise an error is below the minimnum balance' do
      oystercard = Oystercard.new(0)
      expect{ oystercard.touch_in(station) }.to raise_error "Balance too low"
    end

    it 'should return the entry station' do
      oystercard = Oystercard.new(10)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'should change status to false' do
      subject.touch_out(station)
      expect(subject.status).to eq false
    end

    it 'should deduct the Minimum_fare from balance' do
      expect{subject.touch_out(station) }.to change{ subject.balance }.by -(Oystercard::Minimum_fare)
    end
  end
  describe '#journey_history' do
    it 'should show us journey history' do
      expect(subject.journey_history).to eq ({})
    end

    it 'should change the count by 1 at touch_out' do
      oystercard = Oystercard.new(10)
      oystercard.touch_in(station)
      expect{ oystercard.touch_out(station) }.to change{ oystercard.journey_history.keys.count }.by 1
    end


  end

end
