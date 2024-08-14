class CreateDotTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :dot_tasks do |t|
      t.references :dot, null: false, foreign_key: true
      t.boolean :is_completed, null: false, default: false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
