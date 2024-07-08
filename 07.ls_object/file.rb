# frozen_string_literal: true

require 'etc'

module Ls
  class File
    PERMISSION = {
      0 => '---',
      1 => '--x',
      2 => '-w-',
      3 => '-wx',
      4 => 'r--',
      5 => 'r-x',
      6 => 'rw-',
      7 => 'rwx'
    }.freeze

    FILE_TYPE = {
      'fifo' => 'p',
      'characterSpecial' => 'c',
      'directory' => 'd',
      'blockSpecial' => 'b',
      'file' => '-',
      'link' => 'l',
      'socket' => 's'
    }.freeze

    attr_reader :name

    def initialize(name)
      @name = name
      @stat = ::File::Stat.new(name)
    end

    def type_and_permission
      combine_type_and_permission(@stat.mode.to_s(8), @name)
    end

    def hard_link
      @stat.nlink
    end

    def owner
      Etc.getpwuid(@stat.uid).name
    end

    def group
      Etc.getgrgid(@stat.gid).name
    end

    def size
      @stat.size
    end

    def time
      @stat.mtime.strftime('%_m %e %H:%M')
    end

    def blocks
      @stat.blocks
    end

    private

    def combine_type_and_permission(mode, file_list)
      type = FILE_TYPE[::File.ftype(file_list)]
      owner = PERMISSION[mode[-3].to_i]
      group = PERMISSION[mode[-2].to_i]
      other = PERMISSION[mode[-1].to_i]
      "#{type}#{owner}#{group}#{other}"
    end
  end
end
