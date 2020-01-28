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

  it 'raises an error when the limit is exceeded' do
    maximum_balance = Oystercard::Limit
    subject.top_up(maximum_balance)
    expect{subject.top_up 1 }.to raise_error 'Top up limit exceeded'
  end
end
