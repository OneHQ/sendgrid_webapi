require "sendgrid_webapi"

client = SendGridWebApi::Client.new("dpj7k9hq")

puts client.blocks.get.inspect