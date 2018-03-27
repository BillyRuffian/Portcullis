FactoryBot.define do
  factory :member do
    sequence( :mid, 500 ){ |n| n.to_s }

    d_as{ Faker::Name.name }
    l_as{ Faker::Name.last_name }
    f_as{ Faker::Name.name_with_middle }
    h{ Faker::HarryPotter.house }
    h_enddt nil
    x false
    
    factory :member_complete do
      after( :create ) do |member, evaluator|
        create_list( :member_address, 3, member: member )
        create_list( :member_committee, 5, member: member )
        create_list( :member_constituency, 1, member: member )
        create_list( :member_election, 5, member: member )
        create_list( :member_government_post, 5, member: member )
      end
    end
  end
end
