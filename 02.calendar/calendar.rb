#!/usr/bin/env ruby

require "date"
require "optparse"

option = {}
opt = OptionParser.new
opt.on("-m MONTH") {|m| option[:m] = m}
opt.on("-y YEAR") {|y| option[:y] = y}
opt.parse(ARGV)

today = Date.today
month = option[:m] ? option[:m].to_i : today.month
year = option[:y] ? option[:y].to_i : today.year

puts "#{month}月 #{year}年".center(20)
puts "日 月 火 水 木 金 土"

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

print "   " * first_date.wday

(first_date..last_date).each do |date|
  print date.day.to_s.rjust(2) + " "
  if date.saturday?
    print "\n"
  end
end
print "\n"
