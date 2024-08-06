class CreateIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :ideas do |t|
      t.references :user, null: false, foreign_key: true
      t.string :body, null: false, default: ''
      t.string :emote, null: false, default: 'blank'
      t.integer :display_order
      t.timestamps
    end
  end
end
