class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    logger.debug("provider: #{provider}")
    if @user = login_from(provider)
      logger.debug("login_user: #{@user}")
      redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = build_from(provider)
        logger.debug("build_user: #{@user}")
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
