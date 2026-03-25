# frozen_string_literal: true

class FileItem
  HALF_WIDTH_BYTE = 1
  HALF_WIDTH_SPACE = 1
  FULL_WIDTH_SPACE = 2

  def initialize(file_name)
    @file_name = file_name
  end

  def padded_name(max_display_width)
    @file_name + (' ' * (max_display_width - display_width))
  end

  def display_width
    @file_name.grapheme_clusters.sum do |text|
      if text.unicode_normalize(:nfc).bytesize == HALF_WIDTH_BYTE
        HALF_WIDTH_SPACE
      else
        FULL_WIDTH_SPACE
      end
    end
  end
end
