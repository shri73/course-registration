# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
USER_COUNT = 5
COURSES_COUNT = 5

USER_COUNT.times do
  User.create(username: Faker::Internet.unique.user_name,
              email: Faker::Internet.unique.email,
              role: %w[admin student].sample,
              password_digest: Faker::Internet.password(min_length: 8, max_length: 70))
end

COURSES_COUNT.times do
  Course.create(name: Faker::ProgrammingLanguage.name)
end