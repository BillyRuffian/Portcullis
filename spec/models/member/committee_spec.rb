require 'rails_helper'

RSpec.describe Member::Committee, type: :model do
  it 'answers true to active? if end_date is nil' do
    committee = FactoryBot.build :member_committee
    active_committee = FactoryBot.build :member_committee, e_dt: nil
    
    expect( committee.active? ).to be false
    expect( active_committee.active? ).to be true
  end
end
