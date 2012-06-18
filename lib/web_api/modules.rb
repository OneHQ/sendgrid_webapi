#loading modules
%w(bounces spam blocks invalid_emails unsubscribes parse event_notification stats profile mail).each do |mod|
  require "web_api/" + mod
end

module SendGridWebApi::Modules
  
  def bounces
    @bounce_instance ||= SendGridWebApi::Bounce.new(@api_user, @api_key)
  end

  def blocks
    @block_instance ||= SendGridWebApi::Block.new(@api_user, @api_key)
  end

  def spam
    @spam_instance ||= SendGridWebApi::Spam.new(@api_user, @api_key)
  end

  def invalid_emails
    @invalid_email_instance ||= SendGridWebApi::InvalidEmail.new(@api_user, @api_key)
  end

  def unsubscribes
    @unsubscribe_instance ||= SendGridWebApi::Unsubscribe.new(@api_user, @api_key)
  end

  def parse_email
    @parse_email_instance ||= SendGridWebApi::ParseEmail.new(@api_user, @api_key)
  end

  def event_notification
    @event_notification_instance ||= SendGridWebApi::EventNotification.new(@api_user, @api_key)
  end

  def stats
    @stats_instance ||= SendGridWebApi::Stats.new(@api_user, @api_key)
  end

  def profile
    @profile_instance ||= SendGridWebApi::Profile.new(@api_user, @api_key)
  end

  def mail
    @mail_instance ||= SendGridWebApi::Mail.new(@api_user, @api_key)
  end

end