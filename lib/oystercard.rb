class Oystercard
  attr_reader :balance, :status
  Limit = 90
  Minimum_fare = 1
  def initialize
    @balance = 10
    @status = false
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end

  def deduct(fair)
    @balance = @balance - fair
  end

  def in_journey?
    @status
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end
end
