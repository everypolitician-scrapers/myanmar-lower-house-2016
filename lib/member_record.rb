require 'field_serializer'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberRecord
  include FieldSerializer

  def initialize(member)
    @member = member
  end

  private

  attr_reader :member

  def names
    person[:name].split(Regexp.union('(or)', '(ခ)'))
  end

  def person
    member[:person]
  end

  def contact_type(type)
    cc = person[:contact_details].select do |c|
      c[:type] == type
    end
    unless cc.first.nil?
      cc.first[:value]
    end
  end
end
