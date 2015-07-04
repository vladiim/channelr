task :zip do
  `zip -r ~/Desktop/Channelr.zip . -x ".git/*"`
end

task :run do
  `bundle exec aws-flow-ruby -f worker.json`
end
