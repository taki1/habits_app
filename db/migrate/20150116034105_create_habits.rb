class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.integer :user_id
      t.string :target
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
