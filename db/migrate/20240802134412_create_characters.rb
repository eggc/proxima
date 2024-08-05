class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :gender
      t.string :job
      t.integer :age
      t.text :interests
      t.integer :display_order
      t.timestamps
    end
  end
end
