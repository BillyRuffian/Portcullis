FactoryBot.define do
  factory :member do
    mid '1'
    d_as{ Faker::Name.name }
    l_as{ Faker::Name.last_name }
    f_as{ Faker::Name.name_with_middle }
    h{ Faker::HarryPotter.house }
    h_enddt nil
    x false
  end
end
