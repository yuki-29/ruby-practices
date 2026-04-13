# frozen_string_literal: true

require 'etc'

class FileItem
  attr_reader :file_name

  HALF_WIDTH_BYTE = 1
  HALF_WIDTH = 1
  FULL_WIDTH = 2

  PERMISSION = { 0 => '---',
                 1 => '--x',
                 2 => '-w-',
                 3 => '-wx',
                 4 => 'r--',
                 5 => 'r-x',
                 6 => 'rw-',
                 7 => 'rwx' }.freeze

  def initialize(file_name)
    @file_name = file_name
    @fs = File.lstat(file_name)
  end

  def padded_name(max_display_width)
    @file_name + (' ' * (max_display_width - display_width))
  end

  def display_width
    @file_name.grapheme_clusters.sum do |text|
      if text.unicode_normalize(:nfc).bytesize == HALF_WIDTH_BYTE
        HALF_WIDTH
      else
        FULL_WIDTH
      end
    end
  end

  def blocks
    @fs.blocks
  end

  def ftype
    @fs.ftype[0].tr('f', '-')
  end

  def nlink
    @fs.nlink
  end

  def owner
    Etc.getpwuid(@fs.uid).name
  end

  def group
    Etc.getgrgid(@fs.gid).name
  end

  def size
    @fs.size
  end

  def mtime
    @fs.mtime.strftime('%-m月 %e %H:%M')
  end

  def link_path
    File.readlink(@file_name) if @fs.ftype == 'link'
  end

  def permission_type
    mode.to_s.chars.map { |number| PERMISSION[number.to_i] }.join
  end

  private

  def mode
    @fs.mode.to_s(8)[-3, 3]
  end
end
