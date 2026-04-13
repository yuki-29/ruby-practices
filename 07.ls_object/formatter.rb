# frozen_string_literal: true

require_relative 'file_item'

class Formatter
  def initialize(file_names)
    @file_items = file_names.map { |file| FileItem.new(file) }
  end

  def format
    raise NotImplementedError
  end
end
