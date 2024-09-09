# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

25.times do |i|
  User.create(
    email: "user#{i+1}@example.com",
    username: Faker::Internet.unique.username,
    password: "password#{i+1}"
  )
end

group_names = ["Innovators Collective", "The Visionaries", "Dynamic Dreamers", "The Pioneers", 'Elite Creators']

5.times do |i|
  Group.create(
    name: group_names[i]
  )
end

5.times do |i|
  Member.create(admin: true, user_id: (5 * (i - 1)) + 1, group_id: i)
  Member.create(admin: false, user_id: (5 * (i - 1)) + 2, group_id: i)
  Member.create(admin: false, user_id: (5 * (i - 1)) + 3, group_id: i)
  Member.create(admin: false, user_id: (5 * (i - 1)) + 4, group_id: i)
  Member.create(admin: false, user_id: (5 * (i - 1)) + 5, group_id: i)
end

Task.create(name: "Exercise", unit: "sessions", quantity: 4, group_id: 1)
Task.create(name: "Read", unit: "book", quantity: 1, group_id: 1)
Task.create(name: "Organize workspace", unit: "hours", quantity: 2, group_id: 2)
Task.create(name: "Meal prep", unit: "meals", quantity: 5, group_id: 2)
Task.create(name: "Learn new skill", unit: "hours", quantity: 3, group_id: 3)
Task.create(name: "Complete a project", unit: "projects", quantity: 1, group_id: 3)
Task.create(name: "Connect with people", unit: "conversations", quantity: 3, group_id: 4)
Task.create(name: "Practice mindfulness", unit: "minutes", quantity: 15, group_id: 4)
Task.create(name: "Set financial goals", unit: "sessions", quantity: 1, group_id: 5)
Task.create(name: "Limit screen time", unit: "hours", quantity: 2, group_id: 5)

(1..25).each do |i|
  task_id = case i
            when 1..5
              [1, 2].sample
            when 6..10
              [3, 4].sample
            when 11..15
              [5, 6].sample
            when 16..20
              [7, 8].sample
            when 21..25
              [9, 10].sample
            end

  # Create the Progress record with incrementing member_id and varying task_id
  Progress.create(completion: rand(0.0..100.0), task_id: task_id, member_id: i)
end

Punishment.create(name: "Buy a round of drinks", group_id: 1)
Punishment.create(name: "Treat everyone to lunch", group_id: 2)
Punishment.create(name: "Cover the next team outing", group_id: 3)
Punishment.create(name: "Give a public apology", group_id: 4)
Punishment.create(name: "Organize a game night", group_id: 5)

Reward.create(name: "Extra day off", group_id: 1)
Reward.create(name: "Gift card to favorite store", group_id: 2)
Reward.create(name: "Dinner at a fancy restaurant", group_id: 3)
Reward.create(name: "Football tickets", group_id: 4)
Reward.create(name: "Personalized trophy", group_id: 5)
