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

  def talking?(user)
    rooms.map{|room| room.users}.flatten.reject{|usr| usr == self}.include?(user)
  end
end
