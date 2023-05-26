class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path, notice: 'User created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to root_path, notice: 'User destroyed', status: :see_other
  end

  private

    def user_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
end
