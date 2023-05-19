class CreateCafes < ActiveRecord::Migration[7.0]
  def change
    create_table :cafes do |t|
      t.string :name, null: false
      t.text :description
      t.string :place_id, null: false
      t.string :address, null: false
      t.datetime :opening_hours
      t.datetime :closing_hours
      t.string :website
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end
  end
end
