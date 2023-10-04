#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def parse_filenames
  ARGV
end

def input_text_or_read_file
  $stdin.read
end

def output_target_count(file_or_text, options)
  line = file_or_text.count("\n")
  word = file_or_text.split(/\s+/).size
  byte = file_or_text.bytesize
  length = [line, word, byte].max.to_s.length
  space = length < 8 ? 8 : length + 3
  output = []
  output << line.to_s.rjust(space) if options[:l]
  output << word.to_s.rjust(space) if options[:w]
  output << byte.to_s.rjust(space) if options[:c]
  puts output.join('')
end

def count(filenames)
  lines = 0
  words = 0
  bytes = 0
  filenames.each_line do |filename|
    readed_file = File.read(filename)
    lines += readed_file.count("\n")
    words += readed_file.split(/\s+/).size
    bytes += readed_file.bytesize
  end
  { line: lines, word: words, byte: bytes }
end

def print_file_count(filename, count, options)
  length = count.values.max.to_s.length
  space = length < 8 ? 8 : length + 3
  output = []
  output << count[:line].to_s.rjust(space) if options[:l]
  output << count[:word].to_s.rjust(space) if options[:w]
  output << count[:byte].to_s.rjust(space) if options[:c]
  output << " #{filename}"
  puts output.join('')
end

def print_total_count(total_count, options)
  length = total_count.values.max.to_s.length
  space = length < 8 ? 8 : length + 3
  output = []
  output << total_count[:line].to_s.rjust(space) if options[:l]
  output << total_count[:word].to_s.rjust(space) if options[:w]
  output << total_count[:byte].to_s.rjust(space) if options[:c]
  puts "#{output.join('')} total"
end

def output_count_stats(options)
  filenames = parse_filenames
  total_counts = { line: 0, word: 0, byte: 0 }
  filenames.each do |filename|
    counts = count(filename)
    print_file_count(filename, counts, options)

    total_counts[:line] += counts[:line]
    total_counts[:word] += counts[:word]
    total_counts[:byte] += counts[:byte]
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
  !ARGV.empty? ? output_count_stats(options) : output_target_count(input_text_or_read_file, options)
end

execution_wc_command(options)
