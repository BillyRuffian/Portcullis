FactoryBot.define do
  factory :member_constituency, class: 'Member::Constituency' do
    n{ Faker::Address.city }
    s_dt{ Faker::Date.between 3.years.ago, Date.today }
    
    after :create do |constituency, evalutator|
      constituency.create_election( FactoryBot.attributes_for( :member_election ) )
    end
  end
end
