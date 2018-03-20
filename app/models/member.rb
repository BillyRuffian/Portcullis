class Member
  include Mongoid::Document
  #include Mongoid::Timestamps::Updated::Short
  include Mongoid::Attributes::Dynamic
  
  validates_presence_of   :member_id
  validates_presence_of   :display_as
  validates_presence_of   :full_title
  validates_presence_of   :house
  validates_uniqueness_of :member_id
  
  embeds_many :government_posts, class_name: 'Member::Post'
  embeds_many :opposition_posts, class_name: 'Member::Post'
  embeds_many :committees,       class_name: 'Member::Committee'
  
  accepts_nested_attributes_for :government_posts,
                                :opposition_posts,
                                :committees
  
  scope :commons, -> { where( house: 'Commons' ) }
  scope :lords, -> { where( house: 'Lords' ) }
  scope :active, -> { where( house_end_date: nil ) }
  scope :alphabetical, -> { order( list_as: :asc ) }
  
  field :mid,     as: :member_id,      type: String
  field :m_frm,   as: :member_from,    type: String
  field :h,       as: :house,          type: String
  field :d_as,    as: :display_as,     type: String
  field :l_as,    as: :list_as,        type: String
  field :f_as,    as: :full_title,     type: String
  field :h_enddt, as: :house_end_date, type: Date
  field :p,       as: :party,          type: String
  field :x,       as: :male,           type: Boolean
  
  index( { member_id: 1 }, unique: true )
  index( { list_as:   1 } )
  
  
  def posts?
    ! government_posts.blank? || ! opposition_posts.blank?
  end
  
  def posts
    posts = []
    posts += government_posts unless government_posts.blank?
    posts += opposition_posts unless opposition_posts.blank?
    posts.sort_by( &:start_date ).reverse
  end
  
  def committees?
    ! committees.blank?
  end
  
  def female?
    ! male?
  end
  
  def gender= value
    self.male = ( value == "M" )
  end
  
end
