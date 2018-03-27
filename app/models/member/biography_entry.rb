class Member::BiographyEntry
  include Mongoid::Document
  
  embedded_in :member
  
  field :category, type: String
  field :entry, type: String
  
  def entries
    entry.split( ', ' )
  end
end
