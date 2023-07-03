#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3
def ls_no_option
  files = Dir.glob('*')
  file_length = files.length
  file_row = (file_length / COLUMN.to_f).ceil

  file = []
  files.each_with_index do |file_name, index|
    row = index % file_row
    file[row] ||= []
    file[row] << file_name
  end
  file
end

def ls_no_option_output
  ls_file = ls_no_option
  space = ls_file.flatten.map(&:length).max + 7
  ls_file.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end
ls_no_option_output
