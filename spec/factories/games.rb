FactoryGirl.define do
  factory :game do
    name        { Faker::Lorem.word }
    send_from   { Faker::Internet.email }
  end
end
