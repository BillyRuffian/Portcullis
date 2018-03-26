require 'rails_helper'

RSpec.feature 'User wants details of an MP', type: :feature do
  scenario 'they visit a page which displays the MP\'s details' do
    member = FactoryBot.create :member_complete, house: 'Commons'
    
    visit mps_path
    expect( page ).to have_link( member.list_as )
    
    click_link( member.list_as )
    expect( page ).to have_content( member.display_as )
  end 
end