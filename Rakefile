task :zip do
  `zip -r ~/Desktop/Channelr.zip . -x ".git/*"`
end

task :run do
  `bundle exec aws-flow-ruby -f worker.json`
end

task :deploy do
  puts """
    1. Push to git
    2. Deploy app from https://console.aws.amazon.com/opsworks/home?region=us-east-1
    3. ssh into the app
    4. cd /srv/www/channlr/current
    5. maybe not: sudo rm -rf .bundle
    6. sudo gem update --system
    7. bundle exec ruby flow/scheduler.rb
  """
end
