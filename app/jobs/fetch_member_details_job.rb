require 'open-uri'

class FetchMemberDetailsJob < ApplicationJob
  queue_as :default
  
  def unpack data, klass
    return nil unless data
    if data.kind_of? Array
      target_object = data.map{ |d| unpack( d, klass ) }
    else
      target_object = klass.new
      data.each_pair do |k,v|
        next unless v
        setter = k.to_s + '=' 
        relation = target_object.relations.with_indifferent_access[k]
        if relation
          # we do this because attribute data is found in a singularized key name immediately beneath the 
          # attribute key. Bizarre, but not my schema. E.g. [:committees][:committee]=[{},{}]
          relation_data = v[k.to_s.singularize.to_sym]
          value = unpack( relation_data, Object.const_get( relation['class_name'] ) )
          if ! value.blank? and ! value.kind_of? Array and relation[:relation] == Mongoid::Relations::Embedded::Many
            value = [value] 
          end
          target_object.send( setter, value )
        else
          target_object.send( setter, v ) if target_object.respond_to? setter
        end
      end
    end
    target_object
  end

  def perform( member_id )
    raise ArgumentError.new 'member_id is not an integer' if not member_id.integer? and not member_id.kind_of? Integer
    
    source = open( Settings.member.details.endpoint % { id: member_id } )
    data = Ox.load( source.read, { mode: :hash_no_attrs, strip_namespace: true } ).deep_transform_keys{ |k| k.to_s.underscore.to_sym }[:members][:member]
    data[:member_id] = member_id.to_s
    
    member = unpack data, Member
#     
#     member = Member.new( {
#       member_id:      data[:member_id].to_s,
#       member_from:    data[:member_from],
#       house:          data[:house],
#       display_as:     data[:display_as],
#       list_as:        data[:list_as],
#       full_title:     data[:full_title],
#       house_end_date: data[:house_end_date],
#       party:          data[:party],
#       male:           data[:gender] == 'M'
#     } )
#     
#     {
#       government_posts: 'Member::Post',
#       opposition_posts: 'Member::Post',
#       committees:       'Member::Committee'
#     }.each_pair do |k,v|
#       if ! data[k].blank?
#         field_data = data[k][k.to_s.singularize.to_sym]
#         field_data = [field_data] unless field_data.kind_of? Array
#         meth = k.to_s + '='
#         member.public_send( meth, field_data.map{ |fd| Object.const_get( v ).new( fd ) }  )
#       end
#     end
    
    Member.collection.find_one_and_update( { mid: member.member_id }, { "$set" => member.as_document.except( :_id ) }, upsert: true )
  end
end
