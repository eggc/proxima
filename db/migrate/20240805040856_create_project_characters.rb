class CreateProjectCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :project_characters do |t|
      t.references :project, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.timestamps

      t.index [:project_id, :character_id], unique: true
    end
  end
end
