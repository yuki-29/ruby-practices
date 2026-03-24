# frozen_string_literal: true

class Formatter
  HALF_WIDTH_BYTE = 1
  HALF_WIDTH_SPACE = 1
  FULL_WIDTH_SPACE = 2
  NUM_COLUMNS = 3

  def initialize(file_names)
    @file_names = file_names
  end

  def formatted_files
    file_matrix = @file_names.map { |row| row + column_space(row) }.each_slice(rows).to_a
    file_matrix[0].zip(*file_matrix[1..]).map { |file_name| file_name.join('   ') }
  end

  private

  def column_space(file_name)
    ' ' * (max_byte - text_display_width(file_name))
  end

  def max_byte
    @max_byte ||= @file_names.map(&:bytesize).max
  end

  def text_display_width(file_name)
    file_name.grapheme_clusters.sum do |text|
      if text.unicode_normalize(:nfc).bytesize == HALF_WIDTH_BYTE
        HALF_WIDTH_SPACE
      else
        FULL_WIDTH_SPACE
      end
    end
  end

  def rows
    @file_names.length.ceildiv(NUM_COLUMNS)
  end
end
