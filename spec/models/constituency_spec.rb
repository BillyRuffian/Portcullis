require 'rails_helper'

RSpec.describe Constituency, type: :model do
  
  context 'must be valid' do
    it { should validate_presence_of( :constituency_id ) }
    
    it 'with keys' do
      keys = Constituency.index_specifications.map( &:key ).map( &:keys ).flatten
      expect( keys.include? :name ).to be true
      expect( keys.include? :constituency_id ).to be true
    end
  end
  
  it 'allows dynamic attributes' do
    expect{ Constituency.new( some_attrbute_not_already_defined: true ) }.not_to raise_error
  end
  
  
  context 'must not have timestamps' do
    it { should_not respond_to( :created_at ) }
    it { should_not respond_to( :updated_at ) }
  end
  
  context 'disallows duplicates' do
    it 'of constituency_id' do
      FactoryBot.create :constituency
      expect{ FactoryBot.create :constituency }.to raise_error Mongoid::Errors::Validations
    end
  end
end
