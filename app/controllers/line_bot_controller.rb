class LineBotController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery with: :null_session, only: [:callback]

  def callback
    head :ok
  end
end
