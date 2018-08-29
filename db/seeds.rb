Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

10.times do
  project = Project.create!(
              user: User.all.sample,
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc + rand(1..3).days,
              end_date: Time.now.utc + rand(3..30).days
            )

  5.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(100),
    )
  end
end


20.times do
  project = Project.all.sample
  backer = User.all.sample

  while backer == project.user
    backer = User.all.sample
  end

  Pledge.create!(
    user: backer,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(10)
  )
end
