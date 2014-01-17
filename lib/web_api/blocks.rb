module SendGridWebApi::Modules
  class Block < SendGridWebApi::Client
    def get options = {}
      block_get_url = "blocks.get.json"
      query_api(block_get_url, options)
    end

    def delete options = {}
      block_delete_url = "blocks.delete.json"
      query_api(block_delete_url, options)
    end

    def count options = {}
      block_count_url = "blocks.count.json"
      query_api(block_count_url, options)
    end
  end  
end