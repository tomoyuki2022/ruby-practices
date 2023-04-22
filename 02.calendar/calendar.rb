#!/usr/bin/env ruby

require "date"
require "optparse"

today = Date.today

option = {}
opt = OptionParser.new
opt.on("-m MONTH") {|m| option[:m] = m}
opt.on("-y YEAR") {|y| option[:y] = y}
opt.parse(ARGV)

month = option[:m] ? option[:m].to_i : today.month
year = option[:y] ? option[:y].to_i : today.year

wday = Date.new(year, month, 1).wday
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

puts "#{month}月 #{year}年".center(22)
puts " 日 月 火 水 木 金 土"
print "   " * wday

(first_day..last_day).each do |date|
  print date.day.to_s.rjust(3)
  if date.saturday?
    print "\n"
  end
end
print "\n"
