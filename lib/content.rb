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

  def self.new_instance(raw_entry)
    self.new(
      title:     raw_entry.title,
      url:       raw_entry.url,
      published: raw_entry.published,
      author:    raw_entry.author
    )
  end
end
