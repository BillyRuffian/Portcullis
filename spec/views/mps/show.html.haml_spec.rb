require 'rails_helper'

RSpec.describe "mps/show.html.haml", type: :view do
  context 'when the member exists' do
    it 'shows the MPs details' do
      member = FactoryBot.create :member
      assign( :member, member )
      
      render
      
      expect( rendered ).to match /#{member.display_as}/
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
      member = FactoryBot.build :member
      member.government_posts = FactoryBot.build_list :member_post, 3
      assign( :member, member )
      
      render
      
      expect( rendered ).to match /#{member.government_posts.first.hansard_name}/
    end
    
    it 'does not show the section when they are absent' do
      assign( :member, FactoryBot.create( :member ) )

      render
      
      expect( rendered ).not_to match /Government \/ Opposition posts/
    end
  end
end
