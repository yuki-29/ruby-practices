# frozen_string_literal: true

require_relative 'formatter'
require_relative 'file_item'

class LongFormatter < Formatter
  def format
    total = "total #{@file_items.map(&:blocks).sum}"
    [total] + @file_items.map { |item| format_file_info(item).join(' ') }
  end

  private

  def format_file_info(item)
    [
      item.ftype + item.permission_type,
      " #{item.nlink.to_s.rjust(2)}",
      "#{item.owner}  #{item.group}",
      " #{item.size.to_s.rjust(4)}",
      "#{item.mtime} #{item.file_name} #{"-> #{item.link_path}" if item.link_path}"
    ]
  end
end
