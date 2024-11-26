#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

NUM_COLUMNS = 3
HALF_WIDTH_BYTE = 1
HALF_WIDTH_SPACE = 1
FULL_WIDTH_SPACE = 2

PERMISSION = { 0 => '---',
               1 => '--x',
               2 => '-w-',
               3 => '-wx',
               4 => 'r--',
               5 => 'r-x',
               6 => 'rw-',
               7 => 'rwx' }.freeze

def max_byte_size(file_names)
  file_names.map(&:bytesize).max
end

def column_space(file_name, file_name_max_width)
  padding_size = file_name_max_width - text_display_width(file_name)
  ' ' * padding_size
end

def text_display_width(file_name)
  text_byte = 0
  file_name.grapheme_clusters do |text|
    text_byte += if text.unicode_normalize(:nfc).bytesize == HALF_WIDTH_BYTE
                   HALF_WIDTH_SPACE
                 else
                   FULL_WIDTH_SPACE
                 end
  end
  text_byte
end

def permission_type(mode)
  mode.to_s.chars.map { |number| PERMISSION[number.to_i] }.join
end

def format_file_info(file_info, link_path)
  [
    file_info[:ftype] + permission_type(file_info[:mode]),
    " #{file_info[:nlink]}",
    "#{file_info[:owner]}  #{file_info[:group]}",
    " #{file_info[:size].to_s.rjust(4)}",
    "#{file_info[:mtime]} #{file_info[:name]}#{link_path}"
  ]
end

options = ARGV.getopts('l')
file_names = Dir.glob('*')

exit if file_names.empty?

file_matrix = []

if options['l']
  total_blocks = 0

  file_names.each do |file_name|
    fs = File.lstat(file_name)
    file_info = { name: file_name,
                  blocks: fs.blocks,
                  ftype: fs.ftype[0].sub(/f/, '-'),
                  mode: fs.mode.to_s(8)[-3, 3],
                  nlink: fs.nlink,
                  owner: Etc.getpwuid(fs.uid).name,
                  group: Etc.getgrgid(fs.gid).name,
                  size: fs.size,
                  mtime: fs.mtime.to_s[5, 11].sub(/-/, ' ') }

    total_blocks += file_info[:blocks]

    link_path = " -> #{File.readlink(file_name)}" if file_info[:ftype] == 'l'

    file_matrix << format_file_info(file_info, link_path)
  end

  puts "total #{total_blocks}"
  file_matrix.each do |i|
    puts i.join(' ')
  end

else

  total_files = file_names.length
  quotient = total_files / NUM_COLUMNS
  remainder = total_files % NUM_COLUMNS
  row_count = remainder.zero? ? quotient : quotient + 1

  max_byte = max_byte_size(file_names)

  file_list_in_space = file_names.map { |row| row + column_space(row, max_byte) }

  file_list_in_space.each_slice(row_count) do |i|
    file_matrix << i
  end

  (file_matrix[0]).zip(*file_matrix[1..]) do |file_name|
    puts file_name.join('   ')
  end

end
