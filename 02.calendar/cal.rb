#! /usr/bin/env ruby

require 'date'
require 'optparse'
opt = OptionParser.new
params= {}

opt.on('-m [MONTH]',Integer){|v| params[:m] = v}
opt.on('-y [YEAR]',Integer){|v| params[:y] = v}
opt.parse!(ARGV)

params[:m] = Date.today.month if params[:m].nil?
params[:y] = Date.today.year if params[:y].nil?

# 2次元配列生成、日付をフォーマット
def generate_day_list(date)
  weekday = date.wday
  month_end = Date.new(date.year,date.month,-1).mday
  indent = Array.new(weekday, "  ")

  day_list_row = (1..month_end)
  day_list = []
  sub_list = []
  sub_list.push(indent)

  day_list_row.each do |i|
    if Date.new(date.year,date.month,i).saturday?
      sub_list.push(i.to_s.rjust(2))
      day_list.push(sub_list)
      sub_list = []
    else
      sub_list.push(i.to_s.rjust(2))
    end
  end
  day_list.push(sub_list) if sub_list.any? 
  return day_list
end
def display(date,list)
  puts "      #{date.month}月 #{date.year}      "
  puts '日 月 火 水 木 金 土'
  list.each {|i| puts i.join(" ")}
end
 
date = Date.new(params[:y],params[:m])

display(date,generate_day_list(date))
