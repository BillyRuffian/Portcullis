require 'open-uri'

class FetchMemberDetailsJob < ApplicationJob
  queue_as :default

  def perform( member_id )
    raise ArgumentError.new 'member_id is not an integer' if not member_id.integer? and not member_id.kind_of? Integer
    
    source = open( Settings.member.details.endpoint % { id: member_id } )
    data = Ox.load( source.read, { mode: :hash_no_attrs, strip_namespace: true } ).deep_transform_keys{ |k| k.to_s.underscore.to_sym }[:members][:member]
    data[:member_id] = member_id.to_s
    
    member = Member.new( {
      member_id:      data[:member_id].to_s,
      member_from:    data[:member_from],
      house:          data[:house],
      display_as:     data[:display_as],
      list_as:        data[:list_as],
      full_title:     data[:full_title],
      house_end_date: data[:house_end_date],
      party:          data[:party],
      male:           data[:gender] == 'M'
    } )
    
    {
      government_posts: 'Member::Post',
      opposition_posts: 'Member::Post',
      committees:       'Member::Committee'
    }.each_pair do |k,v|
      if ! data[k].blank?
        field_data = data[k][k.to_s.singularize.to_sym]
        field_data = [field_data] unless field_data.kind_of? Array
        meth = k.to_s + '='
        member.public_send( meth, field_data.map{ |fd| Object.const_get( v ).new( fd ) }  )
      end
    end
#     
#     if ! data[:government_posts].blank?
#       posts_data = data[:government_posts][:government_post]
#       if posts_data.kind_of? Array
#         member.government_posts = posts_data.map{ |p| Member::Post.new( p ) }
#       else
#         member.government_posts = [Member::Post.new( posts_data )]
#       end
#     end
#     
#     if ! data[:opposition_posts].blank?
#       posts_data = data[:opposition_posts][:opposition_post]
#       if posts_data.kind_of? Array
#         member.opposition_posts = posts_data.map{ |p| Member::Post.new( p ) }
#       else
#         member.opposition_posts = [Member::Post.new( posts_data )]
#       end
#     end
    

#     data[:committees] = data[:committees][:committee] if ! data[:committees].blank?
    
    Member.collection.find_one_and_update( { mid: member.member_id }, { "$set" => member.as_document.except( :_id ) }, upsert: true )
  end
end
