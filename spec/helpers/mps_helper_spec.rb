require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MpsHelper. For example:
#
# describe MpsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MpsHelper, type: :helper do
  
  before :context do
    @male  = FactoryBot.create :member_complete, x: true
    @female = FactoryBot.create :member_complete, x: false
  end
  
  describe 'generates correct pronouns' do
    it 'with male pronouns for men' do
      expect( helper.pronoun( @male, :subject    ) ).to eq 'he'
      expect( helper.pronoun( @male, :object     ) ).to eq 'him'
      expect( helper.pronoun( @male, :possessive ) ).to eq 'his'
    end
    
    it 'with female pronouns for women' do
      expect( helper.pronoun( @female, :subject    ) ).to eq 'she'
      expect( helper.pronoun( @female, :object     ) ).to eq 'her'
      expect( helper.pronoun( @female, :possessive ) ).to eq 'her'
    end
  end
  
  describe 'generates biography' do
    it 'should display the name of the member' do
      expect( helper.biographize(@male) ).to match /#{@male.display_as}/
    end      
  end
end
