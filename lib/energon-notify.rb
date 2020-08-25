require 'slack-ruby-client'
require_relative "modules/search_slack"
require_relative "modules/message_slack"
require_relative "modules/message_discord"
require_relative "credentials"

# Slack Set Up
class EnergonNotify < Credentials
  include MessageSlack
  include SearchOnSlack
  include MessageDiscord

  def initialize(name: '', image: '', slack_enabled: false, slack_token: nil, slack_as_user: false)
    set_credentials
    if slack_enabled
      Slack.configure do |config|
        config.token = slack_token.nil? ? @bot_token : slack_token
        config.raise 'Missing token' unless config.token
      end

      @bot_name = name unless name.empty?
      @bot_icon = image unless image.empty?
      @bot_user = slack_as_user

      @time_client ||= Slack::RealTime::Client.new
      @web_client ||= Slack::Web::Client.new
    end
  end
end
