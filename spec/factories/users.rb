FactoryGirl.define do
  factory :user do
    name            { Faker::Lorem.word }
    email           { Faker::Internet.email }
    level           { Faker::Number.between(1, 10) }
    last_visit_at   { Time.now }
    payed           { true }
    game
  end
end
