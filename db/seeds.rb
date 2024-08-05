# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  def load_hash_from_fixture(fixture_file_name)
    path = "test/fixtures/#{fixture_file_name}"
    yaml = YAML.safe_load_file(path, permitted_classes: [Date])
    yaml.values
  end

  User.upsert_all(load_hash_from_fixture('users.yml'))
  User.connection.execute("SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));")

  Project.upsert_all(load_hash_from_fixture('projects.yml'))
  Project.connection.execute("SELECT setval('projects_id_seq', (SELECT MAX(id) FROM projects));")

  Character.upsert_all(load_hash_from_fixture('characters.yml'))
  Character.connection.execute("SELECT setval('characters_id_seq', (SELECT MAX(id) FROM characters));")

  ProjectCharacter.insert_all(load_hash_from_fixture('project_characters.yml'))
  ProjectCharacter.connection.execute("SELECT setval('project_characters_id_seq', (SELECT MAX(id) FROM project_characters));")
end
