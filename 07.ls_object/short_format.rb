# frozen_string_literal: true

module Ls
  class ShortFormat
    COLUMN = 3
    def initialize(file_list)
      @file_list = file_list
    end

    def format
      space = chunk_file_list.flatten.map(&:length).max + 7
      chunk_file_list.each do |row|
        row.each do |file_list|
          print file_list.ljust(space) unless file_list.nil?
        end
        puts
      end
    end

    private

    def chunk_file_list
      file_length = @file_list.length
      file_row = (file_length / COLUMN.to_f).ceil
      files = []
      @file_list.each_with_index do |list, index|
        row = index % file_row
        files[row] ||= []
        files[row] << list
      end
      files
    end
  end
end
