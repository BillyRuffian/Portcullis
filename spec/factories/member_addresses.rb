FactoryBot.define do
  factory :member_address, class: 'Member::Address' do
    type "Parliamentary"
    is_preferred true
    is_physical true
    address1{ Faker::Address.street_address }
    address2{ Faker::Address.city }
    address3{ Faker::Address.country }
    postcode{ Faker::Address.postcode }
    phone{ Faker::PhoneNumber.cell_phone }
    email{ Faker::Internet.email }
  end
end
