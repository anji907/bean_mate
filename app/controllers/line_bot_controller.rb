require 'lib/line_messaging_api'

class LineBotController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery with: :null_session, only: [:callback]

  def callback
    user = User.find_by(line_user_id: params['events'][0]['source']['userId'])
    push_line(user.line_user_id)
    head :ok
  end
end
