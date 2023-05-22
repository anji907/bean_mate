class RemoveOpeninghoursAndClosinghoursFromCafes < ActiveRecord::Migration[7.0]
  def up
    remove_column :cafes, :opening_hours, :datetime
    remove_column :cafes, :closing_hours, :datetime
  end

  def down
    add_column :cafes, :opening_hours, :datetime
    add_column :cafes, :closing_hours, :datetime
  end
end
