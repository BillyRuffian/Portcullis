require 'open-uri'

class FetchMembersJob < ApplicationJob
  queue_as :default

  def perform
    source = open Settings.members.endpoint 
    data = Ox.load( source.read, mode: :hash ).deep_transform_keys{ |k| k.to_s.underscore.to_sym }

    data[:members][:member].each do |m_data|
      collapsed_m_data = m_data.map(&:to_a).flatten(1).reduce({}) {|h,(k,v)| (h[k] ||= []) << v; h}
      FetchMemberDetailsJob.perform_later collapsed_m_data[:member_id].first
    end
  end
end
