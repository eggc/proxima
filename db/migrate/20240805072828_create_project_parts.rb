class CreateProjectParts < ActiveRecord::Migration[7.1]
  def change
    create_table :project_parts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :display_order
      t.timestamps
    end
  end
end
