class Member::ChairDate < DatedDocument
  include Mongoid::Document
  
  embedded_in :committee, class_name: 'Member::Committee'
  
end
