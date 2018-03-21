require 'rails_helper'

RSpec.describe Member::ChairDate, type: :model do
  it 'should extend DatedDocument' do
    expect( described_class ).to be < DatedDocument
  end
end
