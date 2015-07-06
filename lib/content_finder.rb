require 'feedjira'
require 'sequel'
require_relative 'env'

unless defined?(DB)
  db_options = {adapter: 'postgres', host: ENV['DB_HOST'], port: ENV['DB_PORT'], database: ENV['DB_NAME'], user: ENV['DB_UNAME'], password: ENV['DB_PWORD']}
  DB = ENV['ENVIRONMENT'] == 'production' ? Sequel.connect(db_options) : Sequel.sqlite
end

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
