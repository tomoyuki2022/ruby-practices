#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3
def prepare_output
  get_files = Dir.glob('*')
  file_length = get_files.length
  file_row = (file_length / COLUMN.to_f).ceil

  file = []
  get_files.each_with_index do |file_name, index|
    row = index % file_row
    file[row] ||= []
    file[row] << file_name
  end
  file
end

def output_ls_no_option
  sorted_file = prepare_output
  space = sorted_file.flatten.map(&:length).max + 7
  sorted_file.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end
output_ls_no_option
