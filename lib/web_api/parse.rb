module SendGridWebApi
  class ParseEmail < Client
    def get options = {}
      parse_email_get_url = "parse.get.json"
      query_api(parse_email_get_url, options)
    end

    def set options = {}
      parse_email_set_url = "parse.set.json"
      query_api(parse_email_set_url, options)
    end

    def delete options = {}
      parse_email_delete_url = "parse.delete.json"
      query_api(parse_email_delete_url, options)
    end
  end
end