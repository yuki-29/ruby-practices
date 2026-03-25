# frozen_string_literal: true

require_relative 'fileitem'

class Formatter
  NUM_COLUMNS = 3

  def initialize(file_names)
    @file_items = file_names.map { |file| FileItem.new(file) }
    @max_display_width = @file_items.map(&:display_width).max
  end

  def formatted_files
    file_matrix = @file_items.map { |item| item.padded_name(@max_display_width) }.each_slice(rows).to_a
    file_matrix[0].zip(*file_matrix[1..]).map { |file_name| file_name.join('   ') }
  end

  private

  def rows
    @file_items.length.ceildiv(NUM_COLUMNS)
  end
end
