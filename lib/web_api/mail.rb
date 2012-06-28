module SendGridWebApi::Modules
  class Mail < SendGridWebApi::Client
    def send options = {}
      mail_send_url = "mail.send.json"
      query_post_api(mail_send_url, options)
    end
  end  
end