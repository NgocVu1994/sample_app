User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = "hello world"
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content, title: title) }
end

# comment:
microposts = Micropost.order(:created_at).take(6)
users = User.all
user = users.first
50.times do
  content = Faker::Lorem.sentence(5)
  microposts.each { |micropost| micropost.comments.create!(content: content, user_id: user.id) }
end



# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
