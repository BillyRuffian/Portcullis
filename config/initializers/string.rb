# /initializers/string.rb
class String
  IntegerRegex = /^(\d)+$/

  def integer?
    !!self.match(IntegerRegex)
  end
end
