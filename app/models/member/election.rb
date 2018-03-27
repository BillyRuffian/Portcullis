class Member::Election
  include Mongoid::Document
  
  embedded_in :constituency, class_name: 'Member::Constituency'
  
  field :name, type: String
  field :date, type: Date
  field :type, type: String
end
