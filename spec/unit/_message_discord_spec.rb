require './lib/energon-notify'
require './lib/modules/message_discord'

describe MessageSlack do
  describe '#send_message' do
    let(:text) { 'RTest' }
    let(:slack) { EnergonNotify.new }

    context 'when post succeeds' do
      it { expect(slack.discord_event(text).body).to eq("") }
    end
  end
end
