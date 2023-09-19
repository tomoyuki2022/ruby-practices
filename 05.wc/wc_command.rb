#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def parse_filenames
  ARGV
end

def input_text
  gets('')
end

def read_output_file
  $stdin.read
end

def target_count_output(file_or_text, options)
  line = file_or_text.count("\n")
  word = file_or_text.split(/\s+/).size
  byte = file_or_text.size
  output = []
  output << line.to_s.rjust(8) if options[:l]
  output << word.to_s.rjust(8) if options[:w]
  output << byte.to_s.rjust(8) if options[:c]
  puts output.join('')
end

def target
  $stdin.tty? ? read_output_file : input_text
end

def count(filenames)
  lines = 0
  words = 0
  bytes = 0
  filenames.each_line do |filename|
    readed_file = File.read(filename)
    lines += readed_file.count("\n")
    words += readed_file.split(/\s+/).size
    bytes += readed_file.size
  end
  [lines, words, bytes]
end

def print_file_count(filename, count, options)
  output = []
  output << count[0].to_s.rjust(8) if options[:l]
  output << count[1].to_s.rjust(8) if options[:w]
  output << count[2].to_s.rjust(8) if options[:c]
  output << " #{filename}"
  puts output.join('')
end

def print_total_count(total_count, options)
  output = []
  output << total_count[0].to_s.rjust(8) if options[:l]
  output << total_count[1].to_s.rjust(8) if options[:w]
  output << total_count[2].to_s.rjust(8) if options[:c]
  puts "#{output.join('')} total"
end

def count_stats_output(options)
  filenames = parse_filenames
  total_counts = [0, 0, 0]
  filenames.each do |filename|
    counts = count(filename)
    print_file_count(filename, counts, options)

    total_counts[0] += counts[0]
    total_counts[1] += counts[1]
    total_counts[2] += counts[2]
  end
  print_total_count(total_counts, options) if filenames[1]
end

opt = OptionParser.new
options = {}
opt.on('-c') { |c| options[:c] = c }
opt.on('-l') { |l| options[:l] = l }
opt.on('-w') { |w| options[:w] = w }
opt.parse!

unless options.values.any?
  options[:l] = true
  options[:w] = true
  options[:c] = true
end

def execution_wc_command(options)
  ARGV.any? ? count_stats_output(options) : target_count_output(target, options)
end

execution_wc_command(options)
