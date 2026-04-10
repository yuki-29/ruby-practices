# frozen_string_literal: true

require_relative 'long_formatter'
require_relative 'short_formatter'
require 'optparse'

class LsCommand
  def initialize
    @options = ARGV.getopts('a', 'r', 'l')
    @formatter = build_formatter(collect_file_names)
  end

  def display
    @formatter.format
  end

  private

  def build_formatter(file_names)
    @options['l'] ? LongFormatter.new(file_names) : ShortFormatter.new(file_names)
  end

  def collect_file_names
    dotmatch_files = Dir.glob('*', @options['a'] ? File::FNM_DOTMATCH : 0)
    exit if dotmatch_files.empty?
    @options['r'] ? dotmatch_files.reverse : dotmatch_files
  end
end
