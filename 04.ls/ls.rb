#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

NUM_COLUMNS = 3
HALF_WIDTH_BYTE = 1
HALF_WIDTH_SPACE = 1
FULL_WIDTH_SPACE = 2

options = ARGV.getopts('a')

file_names = if options['a']
               Dir.glob('*', File::FNM_DOTMATCH)
             else
               Dir.glob('*')
             end

exit if file_names.empty?

total_files = file_names.length
quotient = total_files / NUM_COLUMNS
remainder = total_files % NUM_COLUMNS
row_count = remainder.zero? ? quotient : quotient + 1

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

max_byte = max_byte_size(file_names)

file_list_in_space = file_names.map { |row| row + column_space(row, max_byte) }

file_matrix = []
file_list_in_space.each_slice(row_count) do |i|
  file_matrix << i
end

(file_matrix[0]).zip(*file_matrix[1..]) do |file_name|
  puts file_name.join('      ')
end
