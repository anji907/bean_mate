require 'line/bot'

def push_line(line_user_id)
  message = {
    type: 'text',
    text: 'Bean Mateに新しいメッセージが届いています。'
  }
  client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
  }
  response = client.push_message(line_user_id, message)
  p response
end