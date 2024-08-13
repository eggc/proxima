class CreateDots < ActiveRecord::Migration[7.1]
  def change
    create_table :dots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true
      t.string :content, null: false, default: ''
      t.string :category, null: false, default: 'blank'
      t.integer :display_order
      t.timestamps
    end
  end
end
