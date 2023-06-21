class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    puts "provider: #{provider}"
    if @user = login_from(provider)
      puts "login_user: #{@user}"
      redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = build_from(provider)
        @user.email = SecureRandom.uuid + "@example.com"
        @user.save!
        puts "create_user: #{@user}"
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      rescue => e
        puts "----------------errorが発生しました。------------------"
        puts e.message
        flash[:danger] = "Failed to login from #{provider.titleize}!"
        redirect_to root_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
