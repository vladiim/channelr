require 'rufus-scheduler'
require_relative 'starter'

scheduler = Rufus::Scheduler.new

scheduler.every '1h' do
  Starter.new.start
end
