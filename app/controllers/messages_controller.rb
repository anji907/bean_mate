class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'message_channel', { message: render_message(@message) }
      head :ok
    else
      redirect_to room_path(@message.room)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id).merge(user_id: current_user.id)
  end

  def render_message(message)
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
  end
end
