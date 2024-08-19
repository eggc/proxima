class CreateHouseworks < ActiveRecord::Migration[7.1]
  def change
    create_table :houseworks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false, default: ''
      t.date :last_worked_at
      t.integer :display_order
      t.timestamps
    end
  end
end
