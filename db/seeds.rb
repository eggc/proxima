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
  encrypted_password = User.new(password: 'hoge').encrypted_password

  User.upsert_all(
    [
      { id: 1, email: 'alice@example.com', encrypted_password: },
      { id: 2, email: 'bob@example.com', encrypted_password: }
    ]
  )
  User.connection.execute("SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));")

  Project.upsert_all(
    [
      {
        id: 1,
        user_id: 1,
        title: '僕のヒーローアカデミア',
        media: 'comic',
        release_date: '2014-07-07'
      },
      {
        id: 2,
        user_id: 1,
        title: '風来のシレン',
        media: 'game',
        release_date: '1995-12-01'
      },
      {
        id: 3,
        user_id: 1,
        title: '魔法少女まどか☆マギカ',
        media: 'anime',
        release_date: '2011-01-07'
      },
      {
        id: 4,
        user_id: 1,
        title: 'ジョーカー',
        media: 'movie',
        release_date: '2019-10-04'
      },
      {
        id: 5,
        user_id: 2,
        title: '銀河英雄伝説',
        media: 'novel',
        release_date: '1988-12-21'
      }
    ]
  )
  Project.connection.execute("SELECT setval('projects_id_seq', (SELECT MAX(id) FROM projects));")
end
