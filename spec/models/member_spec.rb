require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'must be valid' do
    it{ should validate_presence_of :member_id }
    it { should validate_presence_of( :display_as ) }
    it { should validate_presence_of( :full_title ) }
    it { should validate_presence_of( :house ) }
    
    it 'with keys' do
      keys = Member.index_specifications.map( &:key ).map( &:keys ).flatten
      expect( keys.include? :l_as ).to be true
      expect( keys.include? :mid ).to be true
    end
  end
  
  it 'allows dynamic attributes' do
    expect{ Member.new( some_attrbute_not_already_defined: true ) }.not_to raise_error
  end
  
  context 'must not have timestamps' do
    it { should_not respond_to( :created_at ) }
    it { should_not respond_to( :updated_at ) }
  end
  
  context 'disallows duplicates' do
    it 'of member_id' do
      FactoryBot.create :member
      expect{ FactoryBot.create :member }.to raise_error Mongoid::Errors::Validations
    end
  end
  
  
  context 'is scoped' do
    it 'selects only commons members' do
      commons_member = FactoryBot.create :member, member_id: '10001', house: 'Commons'
      lords_member = FactoryBot.create :member, member_id: '20001', house: 'Lords'
      
      expect( Member.commons ).to eq [commons_member]
    end
    
    it 'selects only lords members' do
      commons_member = FactoryBot.create :member, member_id: '10001', house: 'Commons'
      lords_member = FactoryBot.create :member, member_id: '20001', house: 'Lords'
      
      expect( Member.lords ).to eq [lords_member]
    end
    
    it 'selects only active members' do
      active_member = FactoryBot.create :member, member_id: '10001'
      inactive_member = FactoryBot.create :member, member_id: '10002', house_end_date: Time.now
      
      expect( Member.active ).to eq [active_member]
    end
    
    it 'sorts alphabetically' do
      member_1 = FactoryBot.create :member, member_id: '1', list_as: 'Zzzz'
      member_2 = FactoryBot.create :member, member_id: '2', list_as: 'Mmmm'
      member_3 = FactoryBot.create :member, member_id: '3', list_as: 'Aaaa'
      
      expect( Member.alphabetical ).to eq [member_3, member_2, member_1]
    end
  end
  
  context 'groups opposition and government posts' do
    it 'sorts them' do
      member = FactoryBot.build :member
      opp_posts = FactoryBot.build_list :member_post, 2
      gov_posts = FactoryBot.build_list :member_post, 3
      
      expect( member.posts? ).to be false
      
      member.government_posts = gov_posts
      member.opposition_posts = opp_posts
      
      expect( member.posts? ).to be true
      
      expect( member.posts ).to eq( ( gov_posts + opp_posts ).sort_by{ |p| p.start_date }.reverse )
    end
  end
  
  context 'gender' do
    it 'reports men as men and not women' do
      member = FactoryBot.build :member, x: true
      expect( member.male? ).to be true
      expect( member.female? ).to be false
    end
    
    it 'reports women as women and not men' do
      member = FactoryBot.build :member, x: false
      expect( member.male? ).to be false
      expect( member.female? ).to be true
    end
  end
  
end
