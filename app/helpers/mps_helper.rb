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

end
