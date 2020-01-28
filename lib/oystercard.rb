class Oystercard
  attr_reader :balance
  Limit = 90
  def initialize
    @balance = 0
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end
end
