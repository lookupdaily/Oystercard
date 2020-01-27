class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(value)
    @balance += value
    fail "Top up limit reached" if @balance > Limit
  end

end

Limit = 90
# class Limit
#   def
# end
