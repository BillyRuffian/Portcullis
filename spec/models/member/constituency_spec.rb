require 'rails_helper'

RSpec.describe Member::Constituency, type: :model do
  it 'should extend DatedDocument' do
    expect( Member::Constituency ).to be < DatedDocument
  end
  
  it { should validate_presence_of :name }
end
