require 'rspec'

require_relative '../lib/loader'

describe YahooWeather do

  it "returns the formated wind condition" do
    yw = YahooWeather.new("12345")
    yw.stub(:raw).and_return(File.read("spec/yahoo_response_stub_playa"))

    puts yw.direction.class
    yw.current_wind.should == "9,40"
  end

end

describe WOEIDLocator do
  it "returns the code for playa del carmen" do
    l = WOEIDLocator.new("Playa del Carmen")
    l.stub(:raw).and_return(File.read("spec/woeid_response"))
    l.number.should == "136973"
  end
end


describe Alarm do 

  before(:each) do
    clean_up_test_data
  end

  def clean_up_test_data
    `rm data/fake_alarms`
  end

  it "save info to file" do
    a = Alarm.new("99", "Playa del Carmen")
    a.stub(:file_location).and_return("data/fake_alarms")
    a.stub(:woeid).and_return("136973")
    a.save
    File.read(a.file_location).should == "99, Playa del Carmen, 136973\n"
  end

end



describe Notification do

  let(:n){ Notification.new}

  it "notifies when there is wind" do
    n.stub(:alarms).and_return("10,Playa del Carmen, 13")
    n.stub(:wind_for_location).and_return("12")
    n.should_receive(:positive)
    n.check_alarms
  end


  it "does not notify when there is not enought wind" do
    n.stub(:alarms).and_return("20, Playa del Carmen, 12")
    n.stub(:wind_for_location).and_return("12")
    n.should_receive(:negative)
    n.check_alarms
  end

end
