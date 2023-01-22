require "whd_ticket/version"
require 'time' # to setup the right time format for the api
require 'whd_ticket/whd_rest_method'

module WHD

  class Ticket

    attr_accessor :whd_url, :api_key, :ticket_client, :ticket_subject, :ticket_details, :send_data

    def initialize
      unless ENV["WHD_URL"]
        print "You must set an environment variable for WHD_URL with the url of your WebHelpDesk.\n"
        print "e.g. echo export WHD_URL=https://servicedesk.com >> ~/.profile\n"
        exit
      end
      unless ENV["WHD_API_KEY"]
        print "You must set an environment variable for WHD_API_KEY with the apiKey for the tech creating the ticket.\n"
        print "e.g. echo export WHD_API_KEY=OdWPct19cIZbGIbVJkarpbrIvvx561tErxx87l3l >> ~/.profile\n"
        exit
      end
      @whd_url = ENV["WHD_URL"]
      @api_key = ENV["WHD_API_KEY"]

      # get info from user
      print "Enter a client usename for the ticket.\n"
      @ticket_client = gets.chomp
      print "Enter a subject for the ticket.\n"
      @ticket_subject = gets.chomp
      print "Enter the ticket details.\n"
      @ticket_details = gets.chomp

      @whd_utc_time = Time.now.strftime("%Y-%m-%d\T%H:%M:%S\Z")
      @send_data = {
        :reportDateUtc => @whd_utc_time,
        :emailClient => true,
        :emailTech => true,
        :emailTechGroupLevel => false,
        :emailGroupManager => false,
        :emailCc => false,
        :emailBcc => false,
        :subject => @ticket_subject,
        :detail => @ticket_details,
        :assignToCreatingTech => true,
        :problemtype => {
          :type => "ProblemType",
          :id => 124
        },
        :sendEmail => false,
        :clientReporter => {
          :type => "Client",
          :id => @ticket_client
        },
        :customFields => [
          {
            :definitionId => 21,
            :restValue => "WHD"
          },
          {
            :definitionId => 216,
            :restValue => "No"
          }
        ]
      }
    end

    def create
      sendrequest = WHD::SendRestRequest.new(@whd_url, @api_key, @send_data)
      sendrequest.create
    end

  end
end
