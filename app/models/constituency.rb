class Constituency
  include Mongoid::Document
  # rinclude Mongoid::Timestamps::Updated::Short
  include Mongoid::Attributes::Dynamic
  
  validates_presence_of :constituency_id
  validates_presence_of :name
  validates_uniqueness_of :constituency_id
  
  field :constituency_id, type: String
  field :name, type: String
  
  index( { constituency_id: 1}, { unique: true } )
  index( { name: 1 }  )
end
