class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver_id: current_user).order(created_at: :desc).page(params[:page])
  end

  def show
    @notification = current_user.passive_notifications.find(params[:id])
    @notification.update(is_read: true) if @notification.is_read == false
    redirect_to room_path(@notification.notifiable.room)
  end
end
