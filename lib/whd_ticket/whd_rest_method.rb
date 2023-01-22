require 'json'
require 'net/http'

module WHD
  class SendRestRequest

    def initialize(whd_url, api_key, data)
      @whd_url      = whd_url
      @whd_url_path = "/helpdesk/WebObjects/Helpdesk.woa"
      @api_key      = api_key
      @data         = data
    end

    def create

      url = "#{@whd_url}#{@whd_url_path}/ra/Tickets"
      uri = URI.parse(url)
      params = { :apiKey => @api_key }
      uri.query = URI.encode_www_form(params)

      http = Net::HTTP.new(uri.host, uri.port)
      # http.set_debug_output $stdout
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = "application/json"

      request.body = @data.to_json

      response = http.request(request)

      begin
        json = JSON.parse(response.body)
      rescue JSON::ParserError => e
        print "There seems to be an issue with the json reponse. Please have a look!!\n"
        return
      end

      if response.code == '201'
        print "Ticket with id: #{json["id"]} and subject '#{json["subject"]}' has been created.\n"
      else
        print "There was an error creating the ticket.\n"
        print "http code    : #{response.code}"
        print "http message : #{respnse.message}"
      end
    end
  end
end
