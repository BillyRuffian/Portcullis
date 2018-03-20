require 'rails_helper'

RSpec.describe FetchMemberDetailsJob, type: :job do
  TEST_MEMBER_ID = '172'

  it 'should fetch member details and store it in the database' do
    now = Member.count
    FetchMemberDetailsJob.perform_now( TEST_MEMBER_ID )
    expect( Member.count ).to eq( now + 1 )
  end
  
  it 'should update existing members' do
    member = FactoryBot.create :member, member_id: TEST_MEMBER_ID
    now = Member.count
    FetchMemberDetailsJob.perform_now( TEST_MEMBER_ID )
    expect( Member.count ).to eq( now )
  end
  
  context 'arguments must be valid ' do
    it 'should not raise an error if an integer or a stringified integer is passed' do
      expect{ FetchMemberDetailsJob.perform_now( TEST_MEMBER_ID.to_i) }.not_to raise_error
      expect{ FetchMemberDetailsJob.perform_now( TEST_MEMBER_ID ) }.not_to raise_error
    end
  
    it 'should raise an ArgumentError if no arguments are passed' do
      expect{ FetchMemberDetailsJob.perform_now }.to raise_error ArgumentError
    end
    
    it 'should raise an ArgumentError if more than one argument is passed' do
      expect{ FetchMemberDetailsJob.perform_now( '1', '2', ) }.to raise_error ArgumentError
    end
    
    it 'should raise an ArgumentError if it is not passed an integer or a string parseable to an integer' do
      expect{ FetchMemberDetailsJob.perform_now( 'abc') }.to raise_error ArgumentError
      expect{ FetchMemberDetailsJob.perform_now( '1.1' ) }. to raise_error ArgumentError
    end
  end
end
