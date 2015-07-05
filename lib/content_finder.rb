require 'feedjira'
require 'sequel'

DB = Sequel.sqlite unless defined?(DB)

unless DB.tables.include?(:contents)
  DB.create_table :contents do
    primary_key :id
    String :title
    String :url
    Time :published
    String :author
  end
end

class ContentFinder
  attr_reader :entries
  def initialize
    url      = 'http://www.buzzfeed.com/index.xml'
    feed     = Feedjira::Feed.fetch_and_parse(url)
    @entries = feed.entries
  end

  def add_entries
    entries.map { |entry| Content.create_if_new(entry) }
  end
end

class Content < Sequel::Model

  plugin :validation_helpers
  def validate
    super
    validates_presence [:title, :url, :published]
    validates_unique [:title, :url]
    validates_type Time, :published
    validates_format /\Ahttps?:\/\//, :url, message: 'is not a valid URL'
  end

  def self.create_if_new(raw_entry)
    content = new_instance(raw_entry)
    content.save if content.valid?
  end

  def new_instance(raw_entry)
    self.new(
      title:     raw_entry.title,
      url:       raw_entry.url,
      published: raw_entry.published,
      author:    raw_entry.author
    )
  end
end
