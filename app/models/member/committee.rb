class Member::Committee < DatedDocument
  include Mongoid::Document
  
  embeds_many :chair_dates, class_name: 'Member::ChairDate'
  
  field :n, as: :name, type: String
  field :nt, as: :end_note, type: Date
  field :is_eo, as: :is_ex_officio, type: Boolean
  field :is_co, as: :is_co_opted, type: Boolean
  field :is_al, as: :is_alternate, type: Boolean
  field :cd,    as: :chair_dates
  
  def chair?
    chair_dates.any?{ |date| date.active? }
  end
end
