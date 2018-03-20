require 'rails_helper'

RSpec.describe MpsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      member_1 = FactoryBot.create :member, member_id: '10001', list_as: 'Zzzz', house: 'Commons'
      member_2 = FactoryBot.create :member, member_id: '10002', list_as: 'Aaaa', house: 'Commons'
      get :index
      expect( response ).to have_http_status(:success)
      expect( assigns( :members ).to_a ).to eq [member_2, member_1]
    end
  end

  describe "GET #show" do
    it "returns http success" do
      member = FactoryBot.create :member, house: 'Commons'
      get :show, params: { id: member.member_id }
      expect(response).to have_http_status(:success)
      expect( assigns( :member ) ).to eq member
    end
    
    it 'returns a success and assigns nil to @member when the member doesn\'t exist' do
      get :show, params: { id: 'nothingtoseehere' }
      expect( response ).to have_http_status( :success )
      expect( assigns( :member ) ).to be_nil
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

end
