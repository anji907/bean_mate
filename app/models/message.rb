class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :notification, as: :notifiable, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 1000 }
end
