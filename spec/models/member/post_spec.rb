require 'rails_helper'

RSpec.describe Member::Post, type: :model do

  it 'answers true to active? if the end_date is nil' do
    post = FactoryBot.build :member_post
    active_post = FactoryBot.build :member_post, e_dt: nil 
    
    expect( post.active? ).to be false
    expect( active_post.active? ).to be true
  end

end
