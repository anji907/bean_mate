class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :nickname, presence: true
  validates :email, uniqueness: true

  has_many_attached :avatars

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :messages, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'receiver_id', dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_cafes, through: :likes, source: :cafe

  enum role: { general: 0, admin: 1 }

  def talking?(user)
    rooms.map{|room| room.users}.flatten.reject{|usr| usr == self}.include?(user)
  end

  def liked?(cafe)
    liked_cafes.include?(cafe)
  end

  def like(cafe)
    liked_cafes << cafe
  end

  def unlike(cafe)
    liked_cafes.destroy(cafe)
  end
end
