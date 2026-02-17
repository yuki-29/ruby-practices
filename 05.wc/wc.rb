#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_WIDTH = 8

def load_options
  options = ARGV.getopts('l', 'w', 'c')
  options = options.transform_values { true } if options.values.none?
  options
end

def file_summary_hash(file)
  file_text = read_input(file)
  build_file_stats_hash(file_text)
end

def read_input(filename)
  filename.empty? ? $stdin.read : File.read(filename)
end

def build_file_stats_hash(input_text)
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
  stats_list.sum { |key_value| key_value[stats_key] }
end

def format_summary(file_stats, file_name, options)
  [
    options['l'] ? format_with_padding(file_stats[:lines]) : nil,
    options['w'] ? format_with_padding(file_stats[:words]) : nil,
    options['c'] ? format_with_padding(file_stats[:bytes]) : nil,
    " #{file_name}"
  ]
end

def format_totals(file_stats_list, options)
  [
    options['l'] ? format_with_padding(calculate_total(file_stats_list, :lines)) : nil,
    options['w'] ? format_with_padding(calculate_total(file_stats_list, :words)) : nil,
    options['c'] ? format_with_padding(calculate_total(file_stats_list, :bytes)) : nil,
    ' total'
  ]
end

def display_summaries(summary_lines)
  summary_lines.each do |summary_line|
    puts summary_line.join('')
  end
end

options = load_options

formatted_summaries = []
file_stats_list = []

file_names = ARGV.empty? ? [''] : ARGV

file_names.each do |file|
  file_stats_list << file_summary = file_summary_hash(file)
  formatted_summaries << format_summary(file_summary, file, options)
end

formatted_summaries << format_totals(file_stats_list, options) if file_names.size > 1

display_summaries(formatted_summaries)
