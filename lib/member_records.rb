# frozen_string_literal: true
require_relative 'scraped/json'
require_relative 'member_record'

class MemberRecords < Scraped::JSON
  field :members do
    all_members
  end

  field :members_of_the_lower_house do
    lower_house_members.map do |mem|
      fragment mem => MemberRecord
    end
  end

  field :next do
    json[:next]
  end

  private

  def all_members
    json[:results]
  end

  def lower_house_members
    all_members.select do |mem|
      mem[:organization][:classification] == 'Lower House'
    end
  end
end
