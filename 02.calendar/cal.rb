#! /usr/bin/env ruby

require 'date'
require 'optparse'

class Date_Creation
  def initialize(yyyy,mm)
   @date = Date.new(yyyy,mm)
  end
  def weekday
    weekday = @date.wday
  end
  def month_end
    month_end = Date.new(@date.year,@date.month,-1).mday
  end
  def sunday?(day)
    return Date.new(@date.year,@date.month,day).sunday?   
  end
  def display
    puts "      #{@date.month}月 #{@date.year}      "
    puts '日 月 火 水 木 金 土'
  end
end

opt = OptionParser.new
params= {}
opt.on('-m [MONTH]',Integer){|v| params[:m] = v}
opt.on('-y [YEAR]',Integer){|v| params[:y] = v}
opt.parse!(ARGV)

params[:m] = Date.today.month if params[:m].nil?
params[:y] = Date.today.year if params[:y].nil?

date = Date_Creation.new(params[:y],params[:m])

indent = Array.new(date.weekday, "  ")

day_list_row = (1..date.month_end)
formatted_day_list = []

# 改行、日付をフォーマット
day_list_row.each do |i|
  if date.sunday?(i) 
    formatted_day_list.push("\n")
  end
  if i.to_s.match(/\d{2}/) 
    formatted_day_list.push(i.to_s)
  else
    formatted_day_list.push(" " + i.to_s)
  end
end
day_lists = indent + formatted_day_list

# 出力
date.display
puts day_lists.join(' ').gsub(" \n ","\n")
