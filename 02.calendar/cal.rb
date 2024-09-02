#! /usr/bin/env ruby

require 'date'
require 'optparse'

def generate_calendar_matrix(first_date)
  weekday = first_date.wday
  initial_indent = Array.new(weekday, "  ")
 
  first_date = Date.new(first_date.year, first_date.month, 1)
  last_date = Date.new(first_date.year, first_date.month, -1)
  calendar_matrix = []
  dates_in_week = []
  dates_in_week.push(initial_indent) if initial_indent.any?

  (first_date..last_date).each do |date|
    dates_in_week.push(date.day.to_s.rjust(2))
    if date.saturday?
      calendar_matrix.push(dates_in_week)
      dates_in_week = []
    end
  end
  calendar_matrix.push(dates_in_week) if dates_in_week.any? 
  calendar_matrix
end
def calendar_display(display_date, weekly_array)
  puts "      #{display_date.month}月 #{display_date.year}      "
  puts '日 月 火 水 木 金 土'
  weekly_array.each {|i| puts i.join(" ")}
end

option_parser = OptionParser.new
options= {}

option_parser.on('-m [MONTH]', Integer){|v| options[:m] = v}
option_parser.on('-y [YEAR]', Integer){|v| options[:y] = v}
option_parser.parse!(ARGV)

options[:m] = Date.today.month if options[:m].nil?
options[:y] = Date.today.year if options[:y].nil?

target_date= Date.new(options[:y], options[:m])

calendar_display(target_date, generate_calendar_matrix(target_date))
