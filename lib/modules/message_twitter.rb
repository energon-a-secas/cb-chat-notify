require 'twitter'

module MessageTwitter
  def twitter_event(text, c_key = ENV['TWITTER_C_KEY'], c_secret = ENV['TWITTER_C_SECRET'], a_token = ENV['TWITTER_A_TOKEN'], a_secret = ENV['TWITTER_A_SECRET'])
    tweet = Twitter::REST::Client.new do |config|
      config.consumer_key        = c_key
      config.consumer_secret     = c_secret
      config.access_token        = a_token
      config.access_token_secret = a_secret
    end

    tweet.update(text)
  rescue StandardError => e
    print "Twitter: #{e.message}"
    false
  end
end