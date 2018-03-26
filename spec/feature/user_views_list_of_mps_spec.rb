require 'rails_helper'

RSpec.feature 'User wants a list of MPs', type: :feature do
  
  scenario 'they visit a page and can see all members of parliament' do
    member_1 = FactoryBot.create :member_complete, member_id: '10001', house: 'Commons'
    member_2 = FactoryBot.create :member_complete, member_id: '10002', house: 'Commons'
    
    visit mps_path
    
    expect( page ).to have_link member_1.list_as, href: mp_path( member_1.member_id )
    expect( page ).to have_link member_2.list_as, href: mp_path( member_2.member_id )
  end
  
end