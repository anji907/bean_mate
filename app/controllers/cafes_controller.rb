class CafesController < ApplicationController
  def index
    @q = Cafe.ransack(params[:q])
    @cafes = @q.result(distinct: true).page(params[:page])
  end

  def show
    @cafe = Cafe.find(params[:id])
    @room = Room.new
    @liked_users = @cafe.liked_users
  end
end
