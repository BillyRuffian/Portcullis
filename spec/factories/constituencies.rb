
FactoryBot.define do
  factory :constituency do
    constituency_id '1'
    name{ Faker::Address.state }
    
    
    
    after :create do |constituency, evaluator|
      constituency.create_election( FactoryBot.attributes_for :member_election )
    end
  end
end