class DatedDocument
  include Mongoid::Document
  
  validates_presence_of :start_date
  
  field :s_dt, as: :start_date,           type: Date
  field :e_dt, as: :end_date,             type: Date
  
  
  def active? 
    end_date.blank?
  end
  
end
