require 'discordrb/webhooks'

module MessageDiscord
  def discord_event(text, web_hook = ENV['DISCORD_WEBHOOK'])
    client = Discordrb::Webhooks::Client.new(url: web_hook)
    client.execute do |builder|
      builder.content = text
    end
  rescue StandardError => e
    print "Discord: #{e.message}"
    false
  end
end