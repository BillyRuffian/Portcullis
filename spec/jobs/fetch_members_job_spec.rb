require 'rails_helper'

RSpec.describe FetchMembersJob, type: :job do

  it 'should enqueue FetchMemberDetails jobs' do
    ActiveJob::Base.queue_adapter = :test
    expect{ FetchMembersJob.perform_now }.to have_enqueued_job( FetchMemberDetailsJob ).exactly 3
  end

end
