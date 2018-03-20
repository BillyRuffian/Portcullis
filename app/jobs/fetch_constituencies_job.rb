require 'open-uri'

class FetchConstituenciesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    source = open Settings.constituencies.endpoint
    data = Ox.load( source.read, mode: :hash ).deep_transform_keys{ |k| k.to_s.underscore.to_sym }
    data[:constituencies][:constituency].each do |c_data|
      c = Constituency.new data
      Constituency.collection.find_one_and_update( { constituency_id: c_data[:constituency_id] }, { "$set" => c.attributes.except( '_id' ) }, upsert: true )
    end
  end
end
