require_relative '../lib/content_finder'

class ChannelrActivity
  extend AWS::Flow::Activities

  activity :find_and_add_entries, :say_hello do
    {
      version: '1.0',
    }
  end

  def say_hello(name)
    puts "Hello, #{name}!"
  end

  def find_and_add_entries
    puts 'Adding entries'
    ContentFinder.new.add_entries
  end
end
