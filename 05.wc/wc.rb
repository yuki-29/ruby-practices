#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_WIDTH = 8

def read_input(filename)
  filename.empty? ? $stdin.read : File.read(filename)
end

def build_file_stats(input_text)
  {
    lines: input_text.lines.count,
    words: count_words(input_text.lines),
    bytes: input_text.bytesize
  }
end

def count_words(text_lines)
  text_lines.sum { |line| line.split.length }
end

def format_with_padding(text)
  width = COLUMN_WIDTH - text.to_s.length
  (' ' * width) + text.to_s
end

def calculate_total(stats_list, stats_key)
  stats_list.sum { |i| i[stats_key] }
end

def format_summary(file_stats, file_name, options)
  summary_line = []
  summary_line << format_with_padding(file_stats[:lines]) if options['l']
  summary_line << format_with_padding(file_stats[:words]) if options['w']
  summary_line << format_with_padding(file_stats[:bytes]) if options['c']
  summary_line << " #{file_name}"
  summary_line
end

def display_summaries(summary_lines)
  summary_lines.each do |summary_line|
    puts summary_line.join('')
  end
end

options = ARGV.getopts('l', 'w', 'c')

if options.values.none?
  options['l'] = true
  options['w'] = true
  options['c'] = true
end

formatted_summaries = []
file_stats_list = []

file_names = ARGV.empty? ? [''] : ARGV

file_names.each do |file|
  file_text = read_input(file)
  current_file_stats = build_file_stats(file_text)
  summary_line = format_summary(current_file_stats, file, options)

  formatted_summaries << summary_line
  file_stats_list << current_file_stats
end

if file_names.size > 1
  totals = []
  totals << format_with_padding(calculate_total(file_stats_list, :lines)) if options['l']
  totals << format_with_padding(calculate_total(file_stats_list, :words)) if options['w']
  totals << format_with_padding(calculate_total(file_stats_list, :bytes)) if options['c']
  totals << ' total'
  formatted_summaries << totals
end

display_summaries(formatted_summaries)
