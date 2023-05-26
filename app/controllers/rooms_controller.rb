class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def show
    @room = current_user.rooms.find(params[:id])
    @messages = @room.messages
    @message = Message.new
  end

  def create
    @room = Room.create
    @room_user = RoomUser.create!(room_id: @room.id, user_id: current_user.id)
    @room_user2 = RoomUser.create!(room_id: @room.id, user_id: params[:room][:user_id])
    redirect_to room_path(@room.id)
  end
end
