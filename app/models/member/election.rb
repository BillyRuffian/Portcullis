class Member::Election
  include Mongoid::Document
  
  embedded_in :member
  
  field :name, type: String
  field :date, type: Date
  field :type, type: String
end
