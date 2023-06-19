#! /usr/bin/env ruby
# frozen_string_literal: true

def files
  Dir.glob('*')
end

COLUMN = 3
def ls
  file_length = files.length
  file_row = (file_length / COLUMN.to_f).ceil

  file = Array.new(file_row) { Array.new(COLUMN) }

  files.each_with_index do |file_name, index|
    row_col = index.divmod(file_row)
    row = row_col[1]
    col = row_col[0]
    file[row][col] = file_name
  end

  space = files.map(&:length).max + 7

  file.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end
ls
