class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :habit_id
      t.integer :done, default: 0
      t.datetime :result_at

      t.timestamps
    end
  end
end
