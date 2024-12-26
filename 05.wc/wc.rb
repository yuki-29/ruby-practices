#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

SPACE = 8

def count_words(lines)
  lines.sum { |line| line.split.length }
end

def format_with_padding(text)
  width = SPACE - text.to_s.length
  (' ' * width).to_s + text.to_s
end

options = ARGV.getopts('l', 'w', 'c')
no_option = options.values.none?
file_names = ARGV.empty? ? [''] : ARGV

current_file_summary = []
file_info_matrix = []

total_line = 0
total_word = 0
total_byte = 0

file_names.each_with_index do |file, _i|
  file_text = file == '' ? $stdin.read : File.read(file)

  line_count = file_text.lines.count
  word_count = count_words(file_text.lines)
  bytesize_count = file_text.bytesize

  total_line += line_count
  total_word += word_count
  total_byte += bytesize_count

  current_file_summary << format_with_padding(line_count) if options['l'] || no_option
  current_file_summary << format_with_padding(word_count) if options['w'] || no_option
  current_file_summary << format_with_padding(bytesize_count) if options['c'] || no_option
  current_file_summary << " #{file}"

  file_info_matrix << current_file_summary
  current_file_summary = []
end

file_info_matrix.each do |i|
  puts i.join('')
end

if file_names.size > 1
  totals = []
  totals << format_with_padding(total_line) if options['l'] || no_option
  totals << format_with_padding(total_word) if options['w'] || no_option
  totals << format_with_padding(total_byte) if options['c'] || no_option
  totals << ' total'

  puts totals.join
end
