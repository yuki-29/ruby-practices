# frozen_string_literal: true
require_relative 'Formatter'

puts Formatter.new(Dir.glob('*')).formatted_files
