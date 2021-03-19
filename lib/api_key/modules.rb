#loading modules
%w(management).each do |mod|
  require "api_key/" + mod
end

module SendGridWebApi::ApiKeyModules
  def management
    @management_instance ||= Management.new(@api_key)
  end
end