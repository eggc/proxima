class CreateHouseworkLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :housework_logs do |t|
      t.references :housework, null: false, foreign_key: true
      t.string :memo, null: false, default: ''
      t.date :worked_at, null: false
      t.timestamps

      t.index [:housework_id, :worked_at], order: { worked_at: :desc }
    end
  end
end
