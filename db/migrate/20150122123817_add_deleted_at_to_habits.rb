class AddDeletedAtToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :deleted_at, :datetime
  end
end
