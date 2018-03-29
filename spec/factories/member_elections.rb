FactoryBot.define do
  factory :member_election, class: 'Member::Election' do
    name{ Faker::Address.city }
    date{ Faker::Date.between 3.years.ago, Date.today }
    type 'General Election'
  end
end
