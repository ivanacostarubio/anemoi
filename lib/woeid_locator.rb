#
# USAGE: woeid = WOEIDLocator.new("Playa del Carmen").number
#

class WOEIDLocator
  def initialize(place)
    @place = place.gsub(" ", "+")
  end

  def number
    Nokogiri::XML(raw).xpath("//woeid").inner_text
  end

  private

  def url
    "http://where.yahooapis.com/geocode?q=#{@place}"
  end

  def raw
    RestClient.get(url)
  end
end



