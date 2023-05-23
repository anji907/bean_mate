class RemoveIsopenFromCafes < ActiveRecord::Migration[7.0]
  def change
    remove_column :cafes, :is_open, :boolean
  end
end
