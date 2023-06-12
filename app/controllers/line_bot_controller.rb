class LineBotController < ApplicationController
  protect_from_forgery with: :null_session, only: [:callback]

  def callback
  end
end
