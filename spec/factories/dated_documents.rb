FactoryBot.define do
  factory :dated_document do
    s_dt{ Faker::Date.between 3.years.ago, Date.today } # start date    
    e_dt nil
  end
end
