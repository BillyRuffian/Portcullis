class Member::Constituency < DatedDocument
  include Mongoid::Document
  
  validates_presence_of :name
  
  embedded_in :member
  
  embeds_one :election, class_name: 'Member::Election'
  
  field :n,   as: :name,       type: String
  field :e_r, as: :end_reason, type: String
end
