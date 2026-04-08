# frozen_string_literal: true

require_relative 'formatter'
require_relative 'fileitem'

class LongFormatter < Formatter
  def formatted_files
    total = "total #{@file_items.map(&:blocks).sum}"
    [total] + @file_items.map { |item| long_format(item).join(' ') }
  end

  private

  def long_format(item)
    format_file_info(item.to_h, item.link_path, item.permission_type)
  end

  def format_file_info(file_info, link_path, permission_type)
    [
      file_info[:ftype] + permission_type,
      " #{file_info[:nlink].to_s.rjust(2)}",
      "#{file_info[:owner]}  #{file_info[:group]}",
      " #{file_info[:size].to_s.rjust(4)}",
      "#{file_info[:mtime]} #{file_info[:name]}#{link_path}"
    ]
  end
end
