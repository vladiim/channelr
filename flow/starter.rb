require 'aws/decider'
require 'json'
require_relative 'activities'
require_relative 'workflows'

class Starter
  RETENTION_PERIOD = 1

  attr_reader :runner_file, :swf, :domain, :client
  def initialize(runner_file = 'worker.json')
    @runner_file = runner_file
    @swf         = AWS::SimpleWorkflow.new
    @domain      = setup_domain
    @client      = setup_client
  end

  def setup_domain
    domain = swf.domains[domain_name]
    swf.domains.create(domain_name, RETENTION_PERIOD) unless domain.exists?
    domain
  end

  def domain_name
    @domain_name ||= options.fetch('domain').fetch('name')
  end

  def workflow_workers(worker = 0)
    options.fetch('workflow_workers')[worker]
  end

  def task_list_name(worker = 0)
    workflow_workers(worker).fetch('task_list')
  end

  def setup_client
    @client ||= AWS::Flow::workflow_client(domain.client, domain) do
      { from_class: 'ChannelrWorkflow',
        task_list: task_list_name }
    end
  end

  def start
    puts "Starting a workflow execution."
    puts "  domain:     #{domain_name}"
    puts "  task list:  #{task_list_name}"

    # start the workflow, passing it a name to use.
    client.start_execution("AWS OpsWorks")
  end

  private

  def options
    options = JSON.parse(File.read(runner_file))
  end
end

Starter.new.start

# def setup_domain(domain_name, retention_period)
#   swf = AWS::SimpleWorkflow.new
#   domain = swf.domains[domain_name]
#   unless domain.exists?
#     swf.domains.create(domain_name, retention_period)
#   end
#   domain
# end

# get the path to the runner configuration file.
# if ARGV.length < 1
  # puts "Please provide the path to the runner configuration file!"
  # exit
# end
# runner_spec = ARGV[0]
#
# # Read the domain info from the same JSON file that the runner will be using.
# options     = JSON.parse(File.read(runner_spec)) # worker.json
# domain      = options["domain"]
# domain_name = domain["name"]
# # If retention is not given, default it to 1
# retention_period = domain["retention_in_days"] || 1
#
# # For this test, use the first workflow encountered.
# workflow_info = options["workflow_workers"][0]
#
# task_list_name = workflow_info["task_list"]
#
# domain = setup_domain(domain_name, retention_period)
#
# # Get a workflow client for HelloWorldWorkflow and start a workflow execution
# # with the required options.
# client = AWS::Flow::workflow_client(domain.client, domain) {
#   { from_class: "ChannelrWorkflow",
#     task_list: task_list_name }
# }
#
# puts "Starting a workflow execution."
# puts "  domain:     #{domain_name}"
# puts "  task list:  #{task_list_name}"
#
# # start the workflow, passing it a name to use.
# client.start_execution("AWS OpsWorks")
