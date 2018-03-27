class Member::BasicDetail
  include Mongoid::Document
  
  embedded_in :member, inverse_of: :basic_details
  
  field :t, as: :town_of_birth, type: String
  field :c, as: :country_of_birth, type: String
  
  def place_of_birth
    [town_of_birth, country_of_birth].compact.join( ', ' )
  end
end
