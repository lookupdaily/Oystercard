class Oystercard
  attr_reader :balance, :status, :entry_station, :journey_history
  Limit = 90
  Minimum_fare = 1
  def initialize(balance = 10)
    @balance = balance
    @status = false
    @entry_station = nil
    @journey_history = {}
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end

  def touch_in(station)
    fail "Balance too low" if @balance < Minimum_fare
    @status = true
    @entry_station = station

  end

  def touch_out(station)
    @journey_history[:@entry_station] = station #problem with pushing name of entry station into hash
    deduct(Minimum_fare)
    @entry_station = nil
    @status = false
  end

  private

  def deduct(fair)
    @balance = @balance - fair
  end

end
