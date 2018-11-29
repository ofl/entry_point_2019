# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create(*args)
  FactoryBot.create(*args)
end

def create_user(name: Faker::Internet.user_name.slice(0...15), email: Faker::Internet.email)
  user = create(:user, name: name, email: email)
  user
end

users = []

unless User.exists?
  users << create_user(name: 'testuser', email: 'test@example.com')

  10.times do
    users << create_user
  end
end

articles = []

unless Article.exists?
  users.each do |user|
    rand(5).times do
      articles << create(:article, user: user)
    end
  end

  articles.each do |article|
    rand(3).times do
      create(:comment, user: users.sample, article: article)
    end

    rand(3).times do
      create(:like, user: users.sample, article: article)
    end
  end
end
