
class Credentials
  def set_credentials
    @bot_token = ENV['SLACK_BOT_TOKEN']
    @bot_name = ENV['SLACK_BOT_NAME']
    @bot_icon = ENV['SLACK_BOT_ICON']
    @bot_channel = ENV['SLACK_DEFAULT_CHANNEL']
    @bot_default_output = ENV['SLACK_DEFAULT_OUTPUT']
  end
end