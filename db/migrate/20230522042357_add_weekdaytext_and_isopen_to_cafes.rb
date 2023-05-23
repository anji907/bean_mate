class AddWeekdaytextAndIsopenToCafes < ActiveRecord::Migration[7.0]
  def change
    add_column :cafes, :weekday_text, :string
    add_column :cafes, :is_open, :boolean
  end
end
