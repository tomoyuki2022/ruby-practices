#! /usr/bin/env ruby
# frozen_string_literal: true

def files
  Dir.glob('*')
end

def ls
  column = 3
  file_length = files.length
  file_row = (file_length / column.to_f).ceil

  file = Array.new(file_row) { Array.new(column) }

  get_files.each_with_index do |file_name, index|
    row = index % file_row
    col = index / file_row
    file[row][col] = file_name
  end

  file.each do |row|
    row.each do |file_name|
      print file_name.ljust(20) unless file_name.nil?
    end
    puts
  end
end
ls
