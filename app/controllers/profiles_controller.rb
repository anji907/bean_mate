class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show; end

  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to profiles_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_user
      @user = current_user
    end

    def profile_params
      params.require(:user).permit(:nickname, :bio, :sns_identifier, avatars: [])
    end
end
