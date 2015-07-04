require 'bundler/setup'
require 'aws/decider'
require 'logger'

# These are utilities that are common to all samples and recipes
module SharedUtils

  def setup_domain(domain_name)
    swf = AWS::SimpleWorkflow.new
    domain = swf.domains[domain_name]
    swf.domains.create(domain_name, 10) unless domain.exists?
    domain
  end

  def build_workflow_worker(domain, klass, task_list)
    AWS::Flow::WorkflowWorker.new(domain.client, domain, task_list, klass)
  end

  def build_generic_activity_worker(domain, task_list)
    AWS::Flow::ActivityWorker.new(domain.client, domain, task_list)
  end

  def build_activity_worker(domain, klass, task_list)
    AWS::Flow::ActivityWorker.new(domain.client, domain, task_list, klass)
  end

  def build_workflow_client(domain, options_hash)
    AWS::Flow::workflow_client(domain.client, domain) { options_hash }
  end
end

class CronUtils
  include SharedUtils

  WF_VERSION = "1.0"
  ACTIVITY_VERSION = "1.0"
  WF_TASKLIST = "cron_workflow_task_list"
  ACTIVITY_TASKLIST = "cron_activity_task_list"
  DOMAIN = "Channelr"

  def initialize
    @domain = setup_domain(DOMAIN)
  end

  def activity_worker
    build_activity_worker(@domain, CronActivity, ACTIVITY_TASKLIST)
  end

  def workflow_worker
    build_workflow_worker(@domain, CronWorkflow, WF_TASKLIST)
  end

  def workflow_client
    build_workflow_client(@domain, from_class: "CronWorkflow")
  end

end
