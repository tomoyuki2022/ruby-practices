#!/usr/bin/env ruby

require "date"
require "optparse"

date = Date.today
month = date.month
year = date.year

option = {}
opt = OptionParser.new
opt.on("-m MONTH") {|m| option[:m] = m}
opt.on("-y YEAR") {|y| option[:y] = y}
opt.parse(ARGV)

month = option[:m].to_i if option[:m]
year = option[:y].to_i if option[:y]

week = Date.new(year, month, 1).wday
first_day = Date.new(year, month, 1).day
last_day = Date.new(year, month, -1).day

puts "#{month}月 #{year}年".center(22)
puts " 日 月 火 水 木 金 土"
print "   " * week

(first_day..last_day).each do |day|
  print day.to_s.rjust(3)
  week += 1
  if week % 7 == 0
    print "\n"
  end
end

