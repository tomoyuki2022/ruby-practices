#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN = 3

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

def filenames
  Dir.glob('*')
end

def chunk_filenames(unchunked_filenames)
  file_length = unchunked_filenames.length
  file_row = (file_length / COLUMN.to_f).ceil

  files = []
  unchunked_filenames.each_with_index do |file_name, index|
    row = index % file_row
    files[row] ||= []
    files[row] << file_name
  end
  files
end

def output(chunked_filenames)
  space = chunked_filenames.flatten.map(&:length).max + 7
  chunked_filenames.each do |row|
    row.each do |file_name|
      print file_name.ljust(space) unless file_name.nil?
    end
    puts
  end
end

def permission(mode)
  owner = PERMISSION[mode[-3].to_i]
  group = PERMISSION[mode[-2].to_i]
  other = PERMISSION[mode[-1].to_i]
  "#{owner}#{group}#{other}"
end

def block_number
  total_blocks = filenames.sum { |filename| File::Stat.new(filename).blocks }
  puts "total #{total_blocks}"
end

def ls_l
  block_number
  filenames.each do |filename|
    stats = File::Stat.new(filename)
    file_type = FILE_TYPE[File.ftype(filename)]
    permissions = permission(stats.mode.to_s(8))
    hard_link = stats.nlink
    owner = Etc.getpwuid(stats.uid).name
    group = Etc.getgrgid(stats.gid).name
    size = stats.size
    time = stats.mtime.strftime('%_m %d %H:%M')
    puts "#{file_type}#{permissions}  #{hard_link} #{owner}  #{group} #{size.to_s.rjust(5)} #{time} #{filename}"
  end
end

def parse_options
  ARGV.getopts('l')
end

def ls_other
  chunked_filenames = chunk_filenames(filenames)
  output(chunked_filenames)
end

def exec_ls_command
  options = parse_options
  options['l'] ? ls_l : ls_other
end

exec_ls_command
