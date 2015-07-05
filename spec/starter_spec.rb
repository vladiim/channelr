require_relative 'spec_helper'
# require_relative '../flow/starter.rb'

RSpec.describe 'Starter' do
  let(:subject) { Starter.new }

  describe '#domain_name' do
    it 'parses the domain name' do
      expect(subject.domain_name).to eq('Channelr')
    end

    it 'uses a runner file to parse the domain' do
      test_runner = 'spec/fixtures/test.json'
      subject     = Starter.new(test_runner)
      expect(subject.domain_name).to eq('FIXTURE_DOMAIN')
    end
  end
end
