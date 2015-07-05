require_relative 'spec_helper'
# require_relative '../flow/starter.rb'

# class Starter::SimpleWorkflowStub
#   def domains
#     self
#   end
#
#   def [](domain)
#     ['EXSISTING_DOMAIN'].include?(domain) ? Starter::Domain.new : Starter::NullDomain.new
#   end
#
#   def create
#
#   end
# end
#
# class Starter::NullDomain
#   def exists?
#     true
#   end
# end
#
# class Starter::NullDomain
#   def exists?
#     false
#   end
# end

class Starter::Domain
end

class Starter::Client
end

RSpec.describe 'Starter' do
  let(:test_runner) {'spec/fixtures/test.json'}
  let(:subject)     {Starter.new(test_runner)}

  before do
    allow(subject).to receive(:setup_domain) { Starter::Domain.new }
    allow(subject).to receive(:setup_client) { Starter::Client.new }
  end

  # before { allow(AWS::SimpleWorkflow).to receive(:new) { Starter::SimpleWorkflowStub.new } }

  describe '#domain_name' do
    it 'parses the domain name' do
      expect(subject.domain_name).to eq('FIXTURE_DOMAIN')
    end
  end

  describe '#workflow_workers' do
    it 'parses the workflow workers' do
      first_task_list = {"task_list" => 'FIRST_TASK_LIST'}
      expect(subject.workflow_workers).to eq(first_task_list)
    end
  end

  describe '#task_list_name' do
    it 'parses the task list name' do
      expect(subject.task_list_name).to eq('FIRST_TASK_LIST')
    end
  end

  # client = AWS::Flow::workflow_client(domain.client, domain) {
  #   { from_class: "ChannelrWorkflow",
  #     task_list: task_list_name }
  # }
end
