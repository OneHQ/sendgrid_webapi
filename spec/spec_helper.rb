require 'sendgrid_webapi'
require 'webmock'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.expect_with :rspec do |expectations|
    expectations.syntax = :should
  end
end
