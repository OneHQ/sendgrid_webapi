#loading modules
%w(management bounces unsubscribes spam invalid_emails event_notification parse 
   limits stats ip_management monitor_records white_label iframe auth apps).each do |mod|
  require "sub_user/" + mod
end

module SendGridWebApi::SubUserModules
  def management
    @management_instance ||= Management.new(@api_key)
  end

  def bounces
    @bounce_instance ||= Bounce.new(@api_key)
  end

  def unsubscribes
    @unsubscribe_instance ||= Unsubscribe.new(@api_key)
  end

  def spam
    @spam_instance ||= Spam.new(@api_key)
  end

  def invalid_emails
    @invalid_email_instance ||= InvalidEmail.new(@api_key)
  end
  
  def event_notification
    @event_notification_instance ||= EventNotification.new(@api_key)
  end

  def parse_email
    @parse_instance ||= ParseEmail.new(@api_key)
  end

  def limits
    @limit_instance ||= Limit.new(@api_key)
  end

  def stats
    @stats_instance ||= Stats.new(@api_key)
  end
  
  def ip_management
    @ip_management_instance ||= IpManagement.new(@api_key)
  end

  def monitor_records
    @monitor_record_instance ||= MonitorRecord.new(@api_key)
  end

  def white_label
    @white_label_instance ||= WhiteLabel.new(@api_key)
  end
 
  def iframe
    @iframe_instance ||= Iframe.new(@api_key)
  end

  def auth
    @auth_instance ||= Auth.new(@api_key)
  end

  def apps
    @app_instance ||= App.new(@api_key)
  end
 
end