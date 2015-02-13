namespace :db do 
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Test Admin@admintest",
                         email: "admin@test.co.jp",
                         password: "admintest",
                         password_confirmation: "admintest",
                         admin: true)
    User.create!(name: "t1@t1test",
                         email: "t1@test.co.jp",
                         password: "t1test",
                         password_confirmation: "t1test",
                         admin: false)
  end
end