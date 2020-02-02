class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
    # @complete_journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def exit_station= (station)
    @exit_station = exit_station
  end

  def complete?
    @entry_station != nil && @exit_station != nil
  end
end