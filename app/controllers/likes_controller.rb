class LikesController < ApplicationController
  def create
    @cafe = Cafe.find(params[:cafe_id])
    current_user.like(@cafe)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @cafe = current_user.likes.find(params[:id]).cafe
    current_user.unlike(@cafe)
    respond_to do |format|
      format.turbo_stream
    end
  end
end
