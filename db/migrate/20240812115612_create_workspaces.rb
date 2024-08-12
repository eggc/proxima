class CreateWorkspaces < ActiveRecord::Migration[7.1]
  def change
    create_table :workspaces do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: 'my workspace'
      t.integer :display_order, index: true

      t.timestamps
    end
  end
end
