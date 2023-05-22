class CafesController < ApplicationController
  def index
    @cafes = Cafe.all.page(params[:page])
  end

  def show
    @cafe = Cafe.find(params[:id])
  end
end
