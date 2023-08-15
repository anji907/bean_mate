class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end