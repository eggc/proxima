class CreateDotProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :dot_projects do |t|
      t.references :dot, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
      t.index [:dot_id, :project_id], unique: true
    end
  end
end
