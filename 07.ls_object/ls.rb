# frozen_string_literal: true

require_relative 'formatter'

puts Formatter.new(Dir.glob('*')).formatted_files
