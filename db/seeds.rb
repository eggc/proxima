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

  def reset_id_sequence(model)
    table_name = model.table_name
    sequence_name = "#{table_name}_id_seq"
    sql = "SELECT setval('#{sequence_name}', (SELECT MAX(id) FROM #{table_name}));"
    model.connection.execute(sql)
  end

  User.upsert_all(load_hash_from_fixture('users.yml'))
  reset_id_sequence(User)

  Project.upsert_all(load_hash_from_fixture('projects.yml'))
  reset_id_sequence(Project)

  Character.upsert_all(load_hash_from_fixture('characters.yml'))
  reset_id_sequence(Character)

  ProjectCharacter.insert_all(load_hash_from_fixture('project_characters.yml'))
  reset_id_sequence(ProjectCharacter)

  ProjectPart.upsert_all(load_hash_from_fixture('project_parts.yml'))
  reset_id_sequence(ProjectPart)
end
