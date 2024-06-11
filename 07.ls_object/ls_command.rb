# frozen_string_literal: true

require_relative 'file'
require_relative 'option'
require_relative 'short_format'
require_relative 'long_format'

module Ls
  class Command
    COLUMN = 3
    def initialize
      @options = Option.new
      @file_paths = search_path
    end

    def run
      ls_short = Ls::ShortFormat.new(file_list)
      ls_long = Ls::LongFormat.new(file_list, @file_paths)
      @options.long_format? ? ls_long.format : ls_short.format
    end

    private

    def search_path
      flags = @options.dot_match? ? ::File::FNM_DOTMATCH : 0
      Ls::File.new(Dir.glob('*', flags))
    end

    def file_list
      @options.reverse? ? @file_paths.names.reverse : @file_paths.names
    end
  end
end
ls = Ls::Command.new
ls.run
