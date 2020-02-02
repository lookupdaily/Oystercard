require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_history
  Limit = 90
  Minimum_fare = 1
  def initialize(balance = 10, journey_class = Journey)
    @balance = balance
    @status = false
    @journey_class = journey_class
    @journey_history = []
  end

  def top_up(value)
    fail 'Top up limit exceeded' if value + balance > Limit
    @balance += value
  end

  def touch_in(station)
    fail "Balance too low" if @balance < Minimum_fare
    
    @journey_history << @journey_class.new(entry_station: station)
  end

  def touch_out(station)
    @journey_history[-1].exit_station= (station)
    deduct(Minimum_fare)
  end

  private

  def deduct(fair)
    @balance = @balance - fair
  end

end
