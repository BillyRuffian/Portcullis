require 'rails_helper'

RSpec.feature 'User views homepage', type: :feature do
  scenario 'they see the welcome screen' do
    visit root_path
    expect( page ).to have_title 'Localminster'
  end
end
