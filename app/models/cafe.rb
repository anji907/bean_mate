class Cafe < ApplicationRecord
  has_many_attached :images

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "description", "id", "latitude", "longitude", "name", "place_id", "updated_at", "website", "weekday_text"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["images_attachments", "images_blobs", "likes"]
  end
end
