require './lib/energon-notify'
require './lib/modules/search_slack'

describe SearchOnSlack do
  describe '#conversation_type' do
    let(:text) { 'RTest' }
    let(:test_channel_id) { 'CQZA6RJ2E' }
    let(:test_group_id) { 'CQZA6RJ2E' }
    let(:test_im_id) { 'UR0KGQUQK' }
    let(:fake_channel_id) { 'F4K3CH4NN3L' }
    let(:slack) { EnergonNotify.new(slack_enabled: true) }

    context 'when info search succeeds' do
      it { expect(slack.conversation_type(test_channel_id)).to eql 'channel' }
      it { expect(slack.conversation_type(test_im_id)).to eql 'im' }
    end

    context 'when info search fails' do
      it { expect(slack.conversation_type(fake_channel_id)).to be false }
    end
  end

  describe '#search_messages_on' do
    let(:test_channel_id) { 'CQZA6RJ2E' }
    let(:test_channel_name) { '#hq-development-logs' }
    let(:fake_channel_id) { 'F4K3CH4NN3L' }
    let(:fake_channel_name) { 'hq-development-logs' }
    let(:slack) { EnergonNotify.new(slack_enabled: true) }

    context 'when message search succeeds' do
      it { expect(slack.search_messages_on(test_channel_id).message).equal?(Array) }
      it { expect(slack.search_messages_on(test_channel_id, 0).messages).equal?(Array) }
      it { expect(slack.search_messages_on(test_channel_id, 2).messages).equal?(Array) }
      it { expect(slack.search_messages_on(test_channel_name).message).equal?(Array) }
    end

    context 'when message search fails' do
      it { expect(slack.search_messages_on(fake_channel_id)).to eql("Channel not found #{fake_channel_id}") }
      it { expect(slack.search_messages_on(fake_channel_name)).to eql("Channel not found #{fake_channel_name}") }
    end
  end

  describe '#get_user_list' do
    let(:slack) { EnergonNotify.new(slack_enabled: true) }

    context 'when search for users succeeds' do
      it { expect(slack.get_user_list).equal?(Array) }
    end
  end

  describe '#conversation_list' do
    let(:slack) { EnergonNotify.new(slack_enabled: true) }

    context 'when search for channels succeeds' do
      it { expect(slack.conversation_list).equal?(Array) }
    end
  end
end
