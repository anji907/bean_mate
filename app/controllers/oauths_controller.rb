class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      flash[:success] = "#{provider.titleize}でログインしました。"
      redirect_to root_path
    else
      begin
        @user = build_from(provider)
        @user.email = SecureRandom.uuid + "@example.com"
        @user.external_auth = true

        if @user.valid?
          @user.save!

          authentication = @user.authentications.new(
            user_id: @user.id,
            uid: @user.line_user_id,
            provider: provider
          )

          authentication.save!
        end

        reset_session
        auto_login(@user)
        flash[:success] = "#{provider.titleize}でログインしました。"
        redirect_to root_path
      rescue => e
        puts "----------------errorが発生しました。------------------"
        puts e.message
        flash[:danger] = "#{provider.titleize}でのログインに失敗しました。"
        redirect_to login_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
