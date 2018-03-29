require 'rails_helper'

RSpec.describe "mps/show.html.haml", type: :view do
  context 'when the member exists' do
    it 'shows the MPs details' do
      member = FactoryBot.create :member_complete
      assign( :member, member )
      
      render
      
      expect( rendered ).to match /#{member.display_as}/
    end
    
    
    it 'shows the constituency history' do
      assign( :member, FactoryBot.create( :member_complete ) )
      render
      
      expect( rendered ).to match /Constituency History/
    end
  end
  
  context 'when the member does not exist' do
    it 'shows an error message' do
      assign( :member, nil )
      
      render
      
      expect( rendered ).to match /can't find that member of parliament/
    end
  end
  
  context 'with government / opposition posts' do
    it 'shows them when they are present' do
      member = FactoryBot.create :member_complete
      assign( :member, member )
      
      render
      
      expect( rendered ).to match /#{member.opposition_posts.first.hansard_name}/
    end
    
    it 'does not show the section when they are absent' do
      member = FactoryBot.create( :member_complete )
      member.government_posts = []
      member.opposition_posts = []
      assign( :member, member )

      render
      
      expect( rendered ).not_to match /Government \/ Opposition posts/
    end
  end
end
