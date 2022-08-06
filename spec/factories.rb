FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    token { Faker::Config.random = Random.new(42) }
  end
end