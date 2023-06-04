class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :notification, optional: true, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 1000 }

  def create_message_notification!(current_user)
    notification = current_user.active_notifications.new(
      sender_id: current_user.id,
      receiver_id: get_receiver_id,
      message: 'メッセージが届きました',
      notifiable: self
    )
    notification.save!
  end

  # 通知を受け取る側のuser_idを取得
  def get_receiver_id
    self.room.users.where.not(id: self.user.id).first.id
  end
end
