#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def filenames
  Dir.glob('*')
end

def sort_filenames(unsorted_files)
  file_length = unsorted_files.length
  file_row = (file_length / COLUMN.to_f).ceil

  files = []
  unsorted_files.each_with_index do |file_name, index|
    row = index % file_row
    files[row] ||= []
    files[row] << file_name
  end
  files
end

def output_ls_no_option
  sorted_filenames = sort_filenames(filenames)
  space = sorted_filenames.flatten.map(&:length).max + 7
  sorted_filenames.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end
output_ls_no_option
