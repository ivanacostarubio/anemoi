# USAGE: 
#
# alarm = Alarm.new("10","Playa del Carmen")
# alarm.save
#
# It saves the wind speed and location to file


class Alarm

  attr_accessor :speed, :location


  def initialize(speed, location)
    @speed = speed
    @location = location
  end

  def save
    `echo "#{speed}, #{location}, #{woeid}" >> #{file_location}`
  end

  def woeid
    WOEIDLocator.new(location).number
  end

  def file_location
    'data/alarms'
  end
end

