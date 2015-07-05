# require_relative 'utils'
require_relative '../lib/content_finder'

class ChannelrActivity
  extend AWS::Flow::Activities

  # Define which activities to run.
  activity :say_hello, :find_content do
    {
      version: '1.0',
    }
  end

  # This activity will say hello when invoked by the workflow
  def say_hello(name)
    puts "Hello, #{name}!"
  end

  def find_content
    ContentFinder.new.find_content
  end
end
