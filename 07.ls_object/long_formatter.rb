# frozen_string_literal: true

module Ls
  class LongFormatter
    def initialize(files)
      @files = files
    end

    def format
      puts "total #{@files.map(&:blocks).sum}"
      @files.map do |file|
        print file.type_and_permission
        print " #{file.hard_link.to_s.rjust(2)}"
        print " #{file.owner}"
        print "  #{file.group}"
        print " #{file.size.to_s.rjust(5)}"
        print " #{file.time}"
        print " #{file.name}\n"
      end
    end
  end
end
