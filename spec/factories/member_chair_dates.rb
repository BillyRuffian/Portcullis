FactoryBot.define do
  factory :member_chair_date, class: 'Member::ChairDate' do
    s_dt{ Faker::Date.between 3.years.ago, Date.today } # start date
    e_dt{ Faker::Date.forward 365 } # end date
  end
end
