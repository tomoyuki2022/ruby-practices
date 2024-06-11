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

    attr_reader :names

    def initialize(path)
      @names = path
    end

    def build_stat(file_list, stats)
      {
        type_and_permission: type_and_permission(stats.mode.to_s(8), file_list),
        hard_link: stats.nlink,
        owner: Etc.getpwuid(stats.uid).name,
        group: Etc.getgrgid(stats.gid).name,
        size: stats.size,
        time: stats.mtime.strftime('%_m %e %H:%M'),
        filename: file_list,
        blocks: stats.blocks
      }
    end

    def format_row(data)
      [
        data[:type_and_permission].to_s,
        " #{data[:hard_link].to_s.rjust(2)}",
        " #{data[:owner]}",
        "  #{data[:group]}",
        " #{data[:size].to_s.rjust(5)}",
        " #{data[:time]}",
        " #{data[:filename]}"
      ].join
    end

    private

    def type_and_permission(mode, file_list)
      type = FILE_TYPE[::File.ftype(file_list)]
      owner = PERMISSION[mode[-3].to_i]
      group = PERMISSION[mode[-2].to_i]
      other = PERMISSION[mode[-1].to_i]
      "#{type}#{owner}#{group}#{other}"
    end
  end
end
