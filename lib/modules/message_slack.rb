require_relative 'search_slack'

# Module for message interactions on Slack
module MessageSlack
  include SearchOnSlack

  def discern_end(data, ts = nil)
    @thread = if data.respond_to? :thread_ts
                data.ts
              else
                ts unless ts.nil?
              end
    @channel = if data.respond_to? :channel
                 data.channel
               else
                 data
               end
  end

  def attach_format(data, title, color = '#e93d94')
    text = ''
    data.each { |v| text << "#{v}\n" }
    [{
      "pretext": title,
      "color": color,
      "text": text
    }]
  end

  def send_message(text, data, ts = nil)
    discern_end(data, ts)
    @web_client.chat_postMessage channel: @channel,
                                 text: text,
                                 icon_url: @bot_icon,
                                 username: @bot_name,
                                 thread_ts: @thread,
                                 as_user: @bot_user
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_direct_message(text, channel)
    dm = get_user_id(channel)
    dm == false ? false : send_message(text, dm)
  end

  def send_attachment(attachment, data, ts = nil)
    discern_end(data, ts)
    @web_client.chat_postMessage channel: @channel,
                                 attachments: attachment,
                                 icon_url: @bot_icon,
                                 username: @bot_name,
                                 thread_ts: @thread,
                                 as_user: @bot_user
  end

  def send_file(path, data, ts = nil)
    file = path
    discern_end(data, ts)
    @web_client.files_upload channels: @channel,
                             icon_url: @bot_icon,
                             username: @bot_name,
                             thread_ts: @thread,
                             as_user: @bot_user,
                             file: Faraday::UploadIO.new(file, 'text'),
                             title: File.basename(file),
                             filename: File.basename(file)
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def add_reaction(icon, channel, thread)
    @web_client.reactions_add channel: channel,
                              name: icon,
                              timestamp: thread,
                              icon_url: @bot_icon,
                              username: @bot_name
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end
end
