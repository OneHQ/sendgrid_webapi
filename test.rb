require "sendgrid_webapi"

client = SendGridWebApi::Client.new("app12240625@heroku.com", "dpj7k9hq")

puts client.blocks.get.inspect