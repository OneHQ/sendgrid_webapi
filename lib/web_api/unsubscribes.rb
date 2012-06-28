module SendGridWebApi::Modules
  class Unsubscribe < SendGridWebApi::Client
    def get options = {}
      unsubscribe_get_url = "unsubscribes.get.json"
      query_api(unsubscribe_get_url, options)
    end

    def add options = {}
      unsubscribe_add_url = "unsubscribes.add.json"
      query_api(unsubscribe_add_url, options)
    end

    def delete options = {}
      unsubscribe_delete_url = "unsubscribes.delete.json"
      query_api(unsubscribe_delete_url, options)
    end
  end
end