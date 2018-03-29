class FetchCommonsDivisionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    graph = RDF::Graph.load Settings.commons.divisions.endpoint, format: :ttl
    query = RDF::Query.new( {
      division:{
        RDF::URI( Settings.vocab.dcterms + 'date' ) => :date,
        RDF::URI( Settings.vocab.dcterms + 'title' ) => :title
      }
    })
    
    query.execute( graph ) do |result|
      puts result.title
    end
    
    api_query = RDF::Query.new({
      api:{
        RDF::URI( Settings.vocab.api + 'page' ) => :page,
        RDF::URI( Settings.vocab.xhtml + 'first' ) => :first_page,
        RDF::URI( Settings.vocab.xhtml + 'next' ) => :next_page,
        RDF::URI( Settings.vocab.a9 + 'totalResults' ) => :total,
        RDF::URI( Settings.vocab.a9 + 'itemsPerPage' ) => :items_per_page
      }
    })
    
    api_query.execute( graph ) do |result|
      puts result.next_page
    end
  end
end
