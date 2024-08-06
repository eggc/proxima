class SeedHelper
  def import(model, method: :upsert)
    attributes_list = load_hash_from_fixture(model)

    if method == :insert
      model.insert_all(attributes_list)
    else
      model.upsert_all(attributes_list)
    end

    reset_id_sequence(model)
  end

  private

  def load_hash_from_fixture(model)
    path = "test/fixtures/#{model.table_name}.yml"
    yaml = YAML.safe_load_file(path, permitted_classes: [Date])
    yaml.values
  end

  def reset_id_sequence(model)
    table_name = model.table_name
    sequence_name = "#{table_name}_id_seq"
    sql = "SELECT setval('#{sequence_name}', (SELECT MAX(id) FROM #{table_name}));"
    model.connection.execute(sql)
  end
end
