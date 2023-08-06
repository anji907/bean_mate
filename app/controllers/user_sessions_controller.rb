class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, flash: { success: 'ログインに成功しました。' }
    else
      flash.now[:warning] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    logout
    flash[:info] = 'ログアウトしました。'
    redirect_to login_path, status: :see_other
  end
end
