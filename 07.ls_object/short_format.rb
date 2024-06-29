# frozen_string_literal: true

module Ls
  class ShortFormat
    COLUMN = 3
    def initialize(files)
      @files = files
    end

    def format
      space = chunk_file_names.flatten.map(&:length).max + 7
      chunk_file_names.each do |row|
        row.each do |file_list|
          print file_list.ljust(space) unless file_list.nil?
        end
        puts
      end
    end

    private

    def chunk_file_names
      file_length = file_names.length
      file_row = (file_length / COLUMN.to_f).ceil
      files = []
      file_names.each_with_index do |list, index|
        row = index % file_row
        files[row] ||= []
        files[row] << list
      end
      files
    end

    def file_names
      @files.map(&:name)
    end
  end
end
