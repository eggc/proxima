class CreateUserSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :housework_tool_enabled, null: false
      t.boolean :creative_tool_enabled, null: false

      t.timestamps
    end
  end
end
