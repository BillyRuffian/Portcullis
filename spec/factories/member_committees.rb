FactoryBot.define do
  factory :member_committee, class: 'Member::Committee' do
    n{ Faker::Job.title }# name     
    s_dt{ Faker::Date.between 3.years.ago, Date.today } # start date
    e_dt{ Faker::Date.forward 365 } # end date    
  end
end
