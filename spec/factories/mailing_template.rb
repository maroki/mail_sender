FactoryGirl.define do
  factory :mailing_template do
    subject                 { Faker::Lorem.word }
    text                    { Faker::Lorem.sentence }
    planing_start_time_at   (DateTime.current + 10.days)
    game
  end
end
