class Cafe < ApplicationRecord
  has_many_attached :images

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "description", "id", "latitude", "longitude", "name", "place_id", "updated_at", "website", "weekday_text"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["images_attachments", "images_blobs"]
  end
end
