require 'oystercard'
describe Oystercard do
  it "new card should have a balance of zero" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:balance) }

  it { expect(subject).to respond_to(:top_up).with(1).argument }

  it 'can top up the balance' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'raises an error when the limit is reached' do
    subject.top_up(value)
    expect{subject.top_up value}.to raise_error("Top up limit reached")
  end
end
