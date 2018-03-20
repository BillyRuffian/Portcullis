require 'rails_helper'

RSpec.describe FetchConstituenciesJob, type: :job do
  
  it 'should fetch a list of constituencies and store it in the database' do
    now = Constituency.count
    FetchConstituenciesJob.perform_now
    expect( Constituency.count ).to eq( 4 + now )
  end
  
  it 'should update existing consituencies with the same constituency_id ' do
    now = Constituency.count
    constituency = FactoryBot.create :constituency 
    FetchConstituenciesJob.perform_now
    constituency_updated = Constituency.find_by constituency_id: constituency.constituency_id
    expect( Constituency.count ).to eq( 4 + now )
    # expect( constituency_updated.updated_at > constituency.updated_at )
  end
end
