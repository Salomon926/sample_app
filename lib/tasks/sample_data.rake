namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    puts "Example User"
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    puts "Sal"
    sal = User.create!(name: "Sal",
                         email: "sal@sal.com",
                         password: "salomon",
                         password_confirmation: "salomon")
    sal.toggle!(:admin)
    30.times do |n|
      name  = Faker::Name.name
      puts "#{n+1}: #{name}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all(limit: 6)
    50.times do
      users.each do |user|
        content = Faker::Lorem.sentence(5)
        user.microposts.create!(content: content)
      end
    end
  end
end
