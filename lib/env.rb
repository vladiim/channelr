unless ENV['ENVIRONMENT'] == 'production'
  require 'dotenv'
  Dotenv.load
end
