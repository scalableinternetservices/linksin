# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_user(email,name)
  User.create!(
    email:  email,
    name: name,
    password: "password1234"
  )
end

def create_event(title,description)
  Event.create!(
    title: title,
    description: description
  )
end

def range (min, max)
    rand * (max-min) + min
end

1...10.times do |i|
	create_user("user_#{i}@meow.com", Faker::Name.first_name)
	create_event("Event #{i}", "Cool event")
end

User.all.each do |user|
	Event.all.each do |event|
		if range(0,1) < 0.33
			user.events << event
		end
	end
end