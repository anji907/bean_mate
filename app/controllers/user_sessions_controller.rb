class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, flash: { success: 'Login successful' }
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:info] = 'Logged out!'
    redirect_to login_path, status: :see_other
  end
end
