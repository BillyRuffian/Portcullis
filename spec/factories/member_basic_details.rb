FactoryBot.define do
  factory :member_basic_detail, class: 'Member::BasicDetail' do
    t{ Faker::Address.city }
    c{ Faker::Address.country }  
  end
end
