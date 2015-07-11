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

    client.start_execution('Blah')
  end

  private

  def options
    options = JSON.parse(File.read(runner_file))
  end
end
