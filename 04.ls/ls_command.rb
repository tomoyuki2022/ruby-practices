#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN = 3

def filenames
  Dir.glob('*')
end

def dotmatch_filenames
  Dir.glob('*', File::FNM_DOTMATCH)
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

def set_option
  option = ARGV.getopts('a')
  if option['a']
    output(chunk_filenames(dotmatch_filenames))
  else
    output(chunk_filenames(filenames))
  end
end
set_option
