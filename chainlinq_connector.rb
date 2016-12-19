require 'net/http'

class ChainlinqConnector
  class << self
    CHAINLINQ_URL = "http://raptor2.chainlinq.com/api"

    def hawb_exists?(hawb_number)
      url = CHAINLINQ_URL + "/v2/hawbs/find?hawb=#{hawb_number}"
      response = call_service_now(url, "get")
      return response.code.to_i == 200
    end

    def call_service_now(url, method="get", params=nil)
      puts url
      puts params

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      headers = {'Authorization' => "Token token=\"Ng2u9ypbpvqY7guzTQVg\""}

      if method == "post"
        request = Net::HTTP::Post.new(uri.request_uri, headers)
        request.set_form_data(params)
      elsif method == "put"
        request = Net::HTTP::Put.new(uri.request_uri, headers)
        request.set_form_data(params)
      elsif method == "delete"
        request = Net::HTTP::Delete.new(uri.request_uri, headers)
      else
        request = Net::HTTP::Get.new(uri.request_uri, headers)
      end

        begin
          response = http.request(request)
          return response
        rescue SystemCallError => e
          Utility::ExceptionLogger.log_exception(e)
        end

      return nil
    end
  end
end