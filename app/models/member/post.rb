class Member::Post < DatedDocument
  include Mongoid::Document
#   include Mongoid::Attributes::Dynamic
  
  field :n,    as: :name,                 type: String
  field :lmn,  as: :laying_minister_name, type: String
  field :h_n,  as: :hansard_name,         type: String
  field :nt,   as: :note,                 type: String
  field :e_nt, as: :end_note,             type: String
  field :jt,   as: :is_joint,             type: Boolean
  field :upd,  as: :is_unpaid,            type: Boolean
  field :e,    as: :email,                type: String
  
end
