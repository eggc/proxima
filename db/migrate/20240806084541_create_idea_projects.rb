class CreateIdeaProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :idea_projects do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
      t.index [:idea_id, :project_id], unique: true
    end
  end
end
