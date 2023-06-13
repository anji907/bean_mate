class LineBotController < ApplicationController
  # skip_before_action :require_login
  protect_from_forgery with: :null_session, only: [:callback]

  def callback
    current_user.update(line_user_id: params['events'][0]['source']['userId'])
    push_line(current_user.line_user_id)
    head :ok
  end
end
