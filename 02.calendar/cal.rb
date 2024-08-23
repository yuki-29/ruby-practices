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
  dates_in_week.push(initial_indent)

  (first_date..last_date).each do |date|
    if date.saturday?
      dates_in_week.push(date.day.to_s.rjust(2))
      calendar_matrix.push(dates_in_week)
      dates_in_week = []
    else
      dates_in_week.push(date.day.to_s.rjust(2))
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

options = OptionParser.new
params= {}

options.on('-m [MONTH]', Integer){|v| params[:m] = v}
options.on('-y [YEAR]', Integer){|v| params[:y] = v}
options.parse!(ARGV)

params[:m] = Date.today.month if params[:m].nil?
params[:y] = Date.today.year if params[:y].nil?

target_date= Date.new(params[:y], params[:m])

calendar_display(target_date, generate_calendar_matrix(target_date))
