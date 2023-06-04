class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(receiver_id: current_user).order(created_at: :desc).page(params[:page])
  end
end
