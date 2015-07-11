require 'rufus-scheduler'
require_relative 'content_finder'

scheduler = Rufus::Scheduler.new

scheduler.every '10m' do
  ContentFinder.new.add_entries
end
