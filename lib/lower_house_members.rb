require_relative 'members'

class LowerHouseMembers < Members
  def to_a
    format(lower_house_members)
  end

  private

  def lower_house_members
    all_members.select do |mem|
      mem[:organization][:classification] == 'Lower House'
    end
  end
end
