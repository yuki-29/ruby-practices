# frozen_string_literal: true

require_relative 'game'

frames = Game.new(ARGV[0])
puts frames.total
