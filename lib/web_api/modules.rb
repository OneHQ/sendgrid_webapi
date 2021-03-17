#loading modules
%w(bounces spam blocks invalid_emails unsubscribes parse event_notification stats profile mail).each do |mod|
  require "web_api/" + mod
end

module SendGridWebApi::Modules
  def bounces
    @bounce_instance ||= Bounce.new(@api_key)
  end

  def blocks
    @block_instance ||= Block.new(@api_key)
  end

  def spam
    @spam_instance ||= Spam.new(@api_key)
  end

  def invalid_emails
    @invalid_email_instance ||= InvalidEmail.new(@api_key)
  end

  def unsubscribes
    @unsubscribe_instance ||= Unsubscribe.new(@api_key)
  end

  def parse_email
    @parse_email_instance ||= ParseEmail.new(@api_key)
  end

  def event_notification
    @event_notification_instance ||= EventNotification.new(@api_key)
  end

  def stats
    @stats_instance ||= Stats.new(@api_key)
  end

  def profile
    @profile_instance ||= Profile.new(@api_key)
  end

  def mail
    @mail_instance ||= Mail.new(@api_key)
  end
  
  def sub_user
    @sub_user ||= SendGridWebApi::SubUser.new(@api_key)
  end

  def apikey
    @apikey ||= SendGridWebApi::ApiKey.new(@api_key)
  end
end