class Notification

  def check_alarms
    alarms.each_line do |alarm|
      check_alarm(alarm)
    end
  end


  def alarms
    File.open(file_location)
  end



  def check_alarm(alarm)

    data = alarm.split(",")


    aa = Struct.new(:speed, :location, :woeid)
    alarm = aa.new(data[0].to_i, data[1], data[2])


    current_wind_speed = wind_for_location(alarm.woeid).to_i

    if alarm.speed <= current_wind_speed
      positive(alarm)
    else
      negative(alarm)
    end

  end

  def file_location
    "data/alarms"
  end

  def wind_for_location(woeid)
    YahooWeather.new(woeid).speed
  end

  def positive(alarm)
    p "There is wind in #{alarm.location} #{alarm.speed}"
  end

  def negative(alarm)
    p "No wind @ #{alarm.location} #{alarm.speed}"
  end


  def deliver(location)
    puts "There is Wind at #{location}"
  end


end


