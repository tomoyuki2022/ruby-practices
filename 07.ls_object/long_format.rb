# frozen_string_literal: true

module Ls
  class LongFormat
    def initialize(file_list, file_path)
      @file_list = file_list
      @file_paths = file_path
    end

    def format
      row_data = @file_list.map do |list|
        stat = ::File::Stat.new(list)
        @file_paths.build_stat(list, stat)
      end
      long_format = row_data.map do |data|
        @file_paths.format_row(data)
      end
      block_total = row_data.map { |data| data[:blocks] }.sum
      puts "total #{block_total}"
      puts long_format
    end
  end
end
