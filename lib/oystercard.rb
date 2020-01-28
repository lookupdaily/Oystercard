class Oystercard
  attr_reader :balance, :status
  Limit = 90
  Minimum_fare = 1
  def initialize(balance = 10)
    @balance = balance
    @status = false
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end

  def in_journey?
    @status
  end

  def touch_in
    fail "Balance too low" if @balance < Minimum_fare
    @status = true
  end

  def touch_out
    deduct(Minimum_fare)
    @status = false
  end

  private

  def deduct(fair)
    @balance = @balance - fair
  end

end
