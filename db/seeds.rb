if Rails.env.development?
  puts 'You should run bin/rails db:fixtures:load instead of bin/rails db:seed to create test data'
end
