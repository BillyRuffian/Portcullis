require 'rails_helper'

RSpec.describe Member::Committee, type: :model do
  it 'answers true to active? if end_date is nil' do
    committee = FactoryBot.build :member_committee
    active_committee = FactoryBot.build :member_committee, e_dt: nil
    
    expect( committee.active? ).to be false
    expect( active_committee.active? ).to be true
  end
  
  it 'has a chair if any committee chair_dates are active' do
    committee = FactoryBot.build :member_committee
    expect( committee.chair? ).to be false
    committee.chair_dates = [FactoryBot.build( :member_chair_date )]
    expect( committee.chair? ).to be false
    committee.chair_dates = [FactoryBot.build( :member_chair_date, e_dt: nil )]
    expect( committee.chair? ).to be true 
  end
end
