# frozen_string_literal: true

require_relative 'file'
require_relative 'option'
require_relative 'short_format'
require_relative 'long_format'

module Ls
  class Command
    def initialize
      @option = Option.new
    end

    def run
      files = match_files_by_option.map { |file| Ls::File.new(file) }
      @option.long_format? ? Ls::LongFormat.new(files).format : Ls::ShortFormat.new(files).format
    end

    private

    def match_files_by_option
      flags = @option.dot_match? ? ::File::FNM_DOTMATCH : 0
      files = Dir.glob('*', flags)
      @option.reverse? ? files.reverse : files
    end
  end
end
ls = Ls::Command.new
ls.run
