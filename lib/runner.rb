#!/usr/bin/ruby

require 'optparse'
require_relative 'loader'


options = {}

OptionParser.new do |opts|

    opts.banner = "Usage: anemoi [options]"


    opts.on("-s", "--show","Show the Alarms") do |v|
      puts `cat data/alarms`
    end

    opts.on("-a", "--add", "Adds a New Alarm") do |a|
      Alarm.new(ARGV[0],ARGV[1]).save
      puts "Alarm Added"
    end

    opts.on("-c", "--check", "Check the Alarms") do |c|
      Notification.new.check_alarms
    end

    if ARGV.empty?
      puts opts.help
    end


end.parse!
