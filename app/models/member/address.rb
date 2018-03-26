class Member::Address
  include Mongoid::Document
  
  embedded_in :member
  
  field :type, type: String
  field :is_preferred, type: Mongoid::Boolean
  field :is_physical, type: Mongoid::Boolean
  field :address1, type: String
  field :address2, type: String
  field :address3, type: String
  field :address4, type: String
  field :address5, type: String
  field :postcode, type: String
  field :phone, type: String
  field :email, type: String
end
