class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :media, null: false, default: 'unspecified'
      t.date :release_date
      t.text :description
      t.string :visibility, null: false, default: 'private'
      t.integer :display_order
      t.timestamps
    end
  end
end
