
FactoryBot.define do
  factory :constituency do
    constituency_id '1'
    name{ Faker::Address.state }
  end
end