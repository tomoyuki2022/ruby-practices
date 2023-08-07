#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN = 3

def filenames
  Dir.glob('*')
end

def chunk_filenames(unchunked_filenames)
  file_length = unchunked_filenames.length
  file_row = (file_length / COLUMN.to_f).ceil

  files = []
  params = option
  target_filenames = params['r'] ? unchunked_filenames.reverse : unchunked_filenames
  target_filenames.each_with_index do |file_name, index|
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
  ARGV.getopts('r')
end

def exec_ls_command
  chunked_filenames = chunk_filenames(filenames)
  output(chunked_filenames)
end

exec_ls_command
