require 'aws/decider'
require_relative 'activities'
require_relative 'workflows'
require 'json'
require_relative 'workflows'

def setup_domain(domain_name, retention_period)
  swf = AWS::SimpleWorkflow.new
  domain = swf.domains[domain_name]
  unless domain.exists?
      swf.domains.create(domain_name, retention_period)
  end
  domain
end

# get the path to the runner configuration file.
if ARGV.length < 1
  puts "Please provide the path to the runner configuration file!"
  exit
end
runner_spec = ARGV[0]

# Read the domain info from the same JSON file that the runner will be using.
options     = JSON.parse(File.read(runner_spec))
domain      = options["domain"]
domain_name = domain["name"]
# If retention is not given, default it to 1
retention_period = domain["retention_in_days"] || 1

# For this test, use the first workflow encountered.
workflow_info = options["workflow_workers"][0]

task_list_name = workflow_info["task_list"]

domain = setup_domain(domain_name, retention_period)

# Get a workflow client for HelloWorldWorkflow and start a workflow execution
# with the required options.
client = AWS::Flow::workflow_client(domain.client, domain) {
  { from_class: "ChannelrWorkflow",
    task_list: task_list_name }
}

puts "Starting a workflow execution."
puts "  domain:     #{domain_name}"
puts "  task list:  #{task_list_name}"

# start the workflow, passing it a name to use.
client.start_execution("AWS OpsWorks")

# require_relative 'utils'
# require_relative 'activities'
# require_relative 'workflows'
#
# # These are the initial parameters for the Simple Workflow
#
# # @param job [Hash] information about the job that needs to be run. It
# #   contains a cron string, the function to call (in activity.rb), and the
# #   function call's arguments. The jobs should be short lived to avoid creating
# #   a drift in the  scheduling of activities since the workflow will wait for
# #   the job to finish before it continues as new.
# # @param base_time [Time] time to start the cron workflow
# # @param interval_length [Integer] how often to reset history (seconds)
# job = { cron: "* * * * *",  func: :add, args: [3,4]}
#
# base_time = Time.now
# # The internal length should be longer than the periodicity of the cron job.
# # We have selected a short interval length (127 seconds) so that users can
# # see the workflow continue as new on the swf console. The number 127 was
# # particularly selected because it is the first prime number after 120
# # (120 seconds = 2 minutes)
# interval_length = 127
#
# # Get the workflow client from CronUtils and start a workflow execution with
# # the required options
# CronUtils.new.workflow_client.run(job, base_time, interval_length)
