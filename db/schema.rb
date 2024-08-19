# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_16_155442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "gender"
    t.string "job"
    t.integer "age"
    t.text "interests"
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "dot_projects", force: :cascade do |t|
    t.bigint "dot_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dot_id", "project_id"], name: "index_dot_projects_on_dot_id_and_project_id", unique: true
    t.index ["dot_id"], name: "index_dot_projects_on_dot_id"
    t.index ["project_id"], name: "index_dot_projects_on_project_id"
  end

  create_table "dot_tasks", force: :cascade do |t|
    t.bigint "dot_id", null: false
    t.boolean "is_completed", default: false, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dot_id"], name: "index_dot_tasks_on_dot_id"
  end

  create_table "dots", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "workspace_id", null: false
    t.string "content", default: "", null: false
    t.string "category", default: "blank", null: false
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dots_on_user_id"
    t.index ["workspace_id"], name: "index_dots_on_workspace_id"
  end

  create_table "housework_logs", force: :cascade do |t|
    t.bigint "housework_id", null: false
    t.string "memo", default: "", null: false
    t.date "worked_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["housework_id"], name: "index_housework_logs_on_housework_id"
  end

  create_table "houseworks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "content", default: "", null: false
    t.date "last_worked_at"
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_houseworks_on_user_id"
  end

  create_table "project_characters", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_project_characters_on_character_id"
    t.index ["project_id", "character_id"], name: "index_project_characters_on_project_id_and_character_id", unique: true
    t.index ["project_id"], name: "index_project_characters_on_project_id"
  end

  create_table "project_parts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_parts_on_project_id"
    t.index ["user_id"], name: "index_project_parts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "theme", default: "", null: false
    t.string "title", default: "", null: false
    t.string "media", default: "unspecified", null: false
    t.date "release_date"
    t.text "description"
    t.string "visibility", default: "private", null: false
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "housework_tool_enabled", null: false
    t.boolean "creative_tool_enabled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", default: "my workspace", null: false
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_order"], name: "index_workspaces_on_display_order"
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "characters", "users"
  add_foreign_key "dot_projects", "dots"
  add_foreign_key "dot_projects", "projects"
  add_foreign_key "dot_tasks", "dots"
  add_foreign_key "dots", "users"
  add_foreign_key "dots", "workspaces"
  add_foreign_key "housework_logs", "houseworks"
  add_foreign_key "houseworks", "users"
  add_foreign_key "project_characters", "characters"
  add_foreign_key "project_characters", "projects"
  add_foreign_key "project_parts", "projects"
  add_foreign_key "project_parts", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "user_settings", "users"
  add_foreign_key "workspaces", "users"
end
