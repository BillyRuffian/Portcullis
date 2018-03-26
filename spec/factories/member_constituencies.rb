FactoryBot.define do
  factory :member_constituency, class: 'Member::Constituency' do
    n{ Faker::Address.city }
    s_dt{ Faker::Date.between 3.years.ago, Date.today }
  end
end
