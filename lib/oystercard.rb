require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_history

  LIMIT = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0, journey_class = Journey)
    @balance = balance
    @journey_class = journey_class
    @journey_history = []
  end

  def top_up(amount)
    fail 'Top up limit exceeded' if amount + balance > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Balance too low" if @balance < MINIMUM_FARE
    
    @journey_history << @journey_class.new(entry_station: station)
  end

  def touch_out(station)
    @journey_history[-1].exit_station= (station)
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
