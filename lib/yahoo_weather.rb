#
# USAGE: 
#
# yahoo_weather = YahooWeather.new(12872623)
#
# yahoo_weather.current_wind



class YahooWeather 
  def initialize(uuid)
    @uuid = uuid.gsub(" ", "")
  end

  def current_wind
     speed + "," + direction
  end

  def direction
    scaned_expression[1][0].to_s
  end

  def speed
    scaned_expression[2][0].to_s
  end

  def raw
    make_request
  end

  def make_request
    RestClient.get(url)
  end

  def full_wind_response
    raw.match("yweather:wind.*/").to_s
  end

  def url
    "http://weather.yahooapis.com/forecastrss?u=c&yweather=wind&w=#{@uuid}"
  end

  def scaned_expression
    full_wind_response.scan(/"(.*?)"/)
  end

end
