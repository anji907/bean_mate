class MessageChannel < ApplicationCable::Channel
  include Rails.application.routes.url_helpers

  def subscribed
    @room = Room.find(params[:room_id])
    stream_for @room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def speak(data)
    message = Message.create!(content: data['message'], user_id: current_user.id, room_id: data['room_id'])
    self.class.broadcast_to(@room, { message: message.content, user: message.user.nickname,
      user_id: message.user.id, avatar_url: rails_blob_url(message.user.avatars[0]) })
    
    message.create_message_notification!(current_user)
  end
end
