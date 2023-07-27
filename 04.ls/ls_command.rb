#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN = 3

def filenames
  Dir.glob('*')
end

def chunk_filenames(unchunked_files)
  file_length = unchunked_files.length
  file_row = (file_length / COLUMN.to_f).ceil

  files = []
  unchunked_files.each_with_index do |file_name, index|
    row = index % file_row
    files[row] ||= []
    files[row] << file_name
  end
  files
end

def output(chunked_filenames)
  space = chunked_filenames.flatten.map(&:length).max + 7
  chunked_filenames.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end

def option
  option_r = ARGV.getopts('r')
  target_filenames = option_r['r'] ? filenames.reverse : filenames
  output(chunk_filenames(target_filenames))
end

option
