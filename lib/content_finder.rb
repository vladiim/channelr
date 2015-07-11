require 'feedjira'
require 'sequel'
require_relative 'env'
require_relative 'db'
require_relative 'content'

class ContentFinder
  attr_reader :entries
  def initialize
    url      = 'http://www.buzzfeed.com/community/justlaunched.xml'.freeze
    feed     = Feedjira::Feed.fetch_and_parse(url)
    @entries = feed.entries
  end

  def add_entries
    entries.map do |entry|
      Content.create_if_new(entry)
      puts "Added entry #{entry}\n"
    end
  end
end
