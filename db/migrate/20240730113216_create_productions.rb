class CreateProductions < ActiveRecord::Migration[7.1]
  def change
    create_table :productions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :media
      t.date :release_date
      t.text :description
      t.timestamps
    end
  end
end
