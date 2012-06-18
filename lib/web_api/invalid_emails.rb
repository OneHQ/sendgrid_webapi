module SendGridWebApi
  class InvalidEmail < Client
    def get options = {}
      invalid_email_get_url = "invalidemails.get.json"
      query_api(invalid_email_get_url, options)
    end

    def delete options = {}
      invalid_email_delete_url = "invalidemails.delete.json"
      query_api(invalid_email_delete_url, options)
    end    
  end
end