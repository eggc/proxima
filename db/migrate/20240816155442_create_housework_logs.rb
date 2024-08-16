class CreateHouseworkLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :housework_logs do |t|
      t.references :housework, null: false, foreign_key: true
      t.string :memo, null: false, default: ''
      t.date :worked_at, null: false
      t.timestamps
    end
  end
end
