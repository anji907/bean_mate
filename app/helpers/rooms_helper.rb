module RoomsHelper
  def get_room_id(user)
    room = current_user.rooms & user.rooms
    room[0].id
  end
end
