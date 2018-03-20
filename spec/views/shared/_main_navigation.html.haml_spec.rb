require 'rails_helper'

RSpec.describe "shared/_main_navigation.html.haml", type: :view do

  context 'builds the navigation bar' do
    it 'with links to the two houses' do
      render
      expect( rendered ).to have_link 'Commons'
      expect( rendered ).to have_link 'Lords'
    end
  end

end
