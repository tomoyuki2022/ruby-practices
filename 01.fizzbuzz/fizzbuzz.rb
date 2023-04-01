#!/usr/bin/env ruby
(1..20).each do |x|
  case
  when x % 3 == 0 && x % 5 == 0
    x = "FizzBuzz"
  when x % 3 == 0
    x = "Fizz"
  when x % 5 == 0
    x = "Buzz"
  end
  puts x
end
