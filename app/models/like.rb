class Like < ApplicationRecord
  belongs_to :user
  belongs_to :cafe

  validates :user_id, uniqueness: { scope: :cafe_id }
end
