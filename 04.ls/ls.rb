#! /usr/bin/env ruby
# frozen_string_literal: true

NUM_COLUMNS = 3
DEFAULT_COLUMN_SPACE = 5
LAST_COLUMN_SPASE_NONE = 2
HALF_WIDTH_BYTE = 1
HALF_WIDTH_SPACE = 1
FULL_WIDTH_SPACE = 2

file_names =  Dir.glob('*')

total_files = file_names.length
row_count = total_files / NUM_COLUMNS

def max_byte_size(file_names)
  file_names.map(&:bytesize).max
end

def column_space(file_name, file_name_max_byte, loop_count)
  column_spacing = ''
  if loop_count <= NUM_COLUMNS - LAST_COLUMN_SPASE_NONE
    padding_size = file_name_max_byte - text_byte_size(file_name) + DEFAULT_COLUMN_SPACE
    padding_size.times do
      column_spacing += ' '
    end
  end
  column_spacing
end

def text_byte_size(file_name)
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

file_row_array = []
file_matrix = []
loop_count = 0

file_names.each_with_index do |row, i|
  file_row_array << row + column_space(row, max_byte, loop_count)
  next unless i == row_count

  row_count += file_row_array.length
  file_matrix << file_row_array
  file_row_array = []
  loop_count += 1
end
file_matrix << file_row_array if file_row_array.any?

(file_matrix[0]).zip(*file_matrix[1..]) do |file_name|
  puts file_name.join(' ')
end
