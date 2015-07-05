require 'rufus-scheduler'
require_relative 'starter'

scheduler = Rufus::Scheduler.new

scheduler.every '10m' do
  Starter.new.start
end
