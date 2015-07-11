require_relative 'activities'

# HelloWorldWorkflow class defines the workflows for the HelloWorld sample
class ChannelrWorkflow
  extend AWS::Flow::Workflows

  # Define which workflows to run.
  workflow :find_and_add_entries, :hello do
    {
      version: '1.0',
      default_execution_start_to_close_timeout: 120
    }
  end

  # Create an activity client using the activity_client method to schedule
  # activities
  activity_client(:client) { { from_class: "ChannelrActivity" } }

  # This is the entry point for the workflow
  def hello(name)
    # Use the activity client 'client' to invoke the say_hello activity
    client.say_hello(name)
  end

  def find_and_add_entries
    client.find_and_add_entries
  end
end
