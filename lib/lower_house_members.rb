require_relative 'members'

class LowerHouseMembers < Members
  def to_a
    members.select do |mem|
      mem[:organization][:classification] == 'Lower House'
    end
  end
end
