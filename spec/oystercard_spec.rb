require 'oystercard'
describe Oystercard do
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

  describe '#deduct' do
    it 'should deduct the fair amount from the balance' do
      expect{subject.deduct Oystercard::Minimum_fare }.to change{ subject.balance }.by -(Oystercard::Minimum_fare)
    end
  end

  describe '#in_journey?' do
    it 'should return true or false' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'should change status to true' do
      expect{ subject.touch_in }.to change{ subject.status }.to true
    end

    it 'Should raise an error is below the minimnum balance' do
      oystercard = Oystercard.new(0)
      expect{ oystercard.touch_in }.to raise_error "Balance too low"
    end
  end

  describe '#touch_out' do
    it 'should change status to false' do
      subject.touch_out
      expect(subject.status).to eq false
    end
  end

end
