require 'rails_helper'

RSpec.describe "welcome/index.html.haml", type: :view do
  context 'you search using your postcode' do
    it 'with a form' do
      render
      expect( rendered ).to have_field( 'postcode' )
      expect( rendered ).to have_button( 'Search' )
    end
  end
end
