# frozen_string_literal: true

require_relative 'file'
require_relative 'option'
require_relative 'short_formatter'
require_relative 'long_formatter'

module Ls
  class Command
    def initialize
      @option = Option.new
    end

    def run
      files = match_files.map { |file| Ls::File.new(file) }
      formatter = @option.long_format? ? Ls::LongFormatter.new(files) : Ls::ShortFormatter.new(files)
      formatter.format
    end

    private

    def match_files
      flags = @option.dot_match? ? ::File::FNM_DOTMATCH : 0
      files = Dir.glob('*', flags)
      @option.reverse? ? files.reverse : files
    end
  end
end
ls = Ls::Command.new
ls.run
