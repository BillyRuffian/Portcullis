FactoryBot.define do
  factory :member_post, aliases: [:member_government_post, :member_opposition_post], class: 'Member::Post' do
    n{ Faker::Job.title }# name    
    h_n{ Faker::Job.key_skill } # hansard name 
    s_dt{ Faker::Date.between 3.years.ago, Date.today } # start date
    e_dt{ Faker::Date.forward 365 } # end date
  end
end
