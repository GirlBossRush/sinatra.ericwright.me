require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

# If you're looking here and wondering what's going on below...
# Thank you Heroku :)
scheduler.every '1m' do
  require "net/http"
  require "uri"
  url = 'http://ericwright.me'
  Net::HTTP.get_response(URI.parse(url))
end
