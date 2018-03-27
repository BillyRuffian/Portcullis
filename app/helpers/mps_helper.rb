module MpsHelper

  def pronoun( member, mode )
    case mode
    when :subject
      member.male? ? 'he' : 'she'
    when :object 
      member.male? ? 'him' : 'her'
    when :possessive
      member.male? ? 'his' : 'her'
    end
  end
  
  def biographize( member )
    sentences = []
    
    sentences <<<<-EOL
      #{member.display_as} was born 
      on #{member.date_of_birth.to_s( :long_ordinal )}
      #{member.basic_details.place_of_birth}
      and is
      #{distance_of_time_in_words_to_now( member.date_of_birth )} old.
    EOL
    
    first_constituency = member.constituencies.order( &:start_date ).reverse.first
    sentences <<<<-EOL
      #{pronoun( member, :subject ).capitalize} was first elected 
      in a  in a #{first_constituency.election.type.downcase}
      on #{first_constituency.start_date.to_s( :long_ordinal )}
      to the constituency of #{first_constituency.name} when #{pronoun( member, :subject)} was 
      #{distance_of_time_in_words( member.date_of_birth, first_constituency.start_date )} old.
    EOL
    
    member.biography_entries.each do |be|
      sentences <<<<-EOL
        #{pronoun( member, :possessive ).capitalize} #{be.category.downcase} are #{to_sentence( be.entries )}.
      EOL
    end
    
    sentences.compact.join( " " )
  end

end
