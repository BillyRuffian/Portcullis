require 'rails_helper'

RSpec.describe DatedDocument, type: :model do
  context 'is valid' do
    it{ should validate_presence_of :start_date }
    
    it 'should answer to active? as true if there is no end date' do
      dd = FactoryBot.create :dated_document
      expect( dd.active? ).to be true
    end
    
    it 'should answer to active? as false if there is an end date' do
      dd = FactoryBot.create :dated_document, e_dt: Date.today
      expect( dd.active? ).to be false
    end
  end
end
