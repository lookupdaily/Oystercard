class Oystercard
  attr_reader :balance, :status, :entry_station
  Limit = 90
  Minimum_fare = 1
  def initialize(balance = 10)
    @balance = balance
    @status = false
    @entry_station = nil
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end

  def touch_in(station)
    fail "Balance too low" if @balance < Minimum_fare
    @entry_station = station
    @status = true
  end

  def touch_out
    deduct(Minimum_fare)
    @entry_station = nil
    @status = false
  end

  private

  def deduct(fair)
    @balance = @balance - fair
  end

end
