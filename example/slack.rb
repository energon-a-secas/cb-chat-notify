require 'energon-notify'

e = EnergonNotify.new(slack_enabled: true, slack_token: 'xoxb-123123123-456456456')
e.send_message('hello', '#your-favorite-channel')