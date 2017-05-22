# frozen_string_literal: true

require 'scraped'
require_relative 'member_record'

class MemberRecordsPage < Scraped::JSON
  field :members_of_the_lower_house do
    lower_house_members.map do |mem|
      fragment mem => MemberRecord
    end
  end

  field :next do
    json[:next]
  end

  private

  def lower_house_members
    json[:results].select do |mem|
      mem[:organization][:classification] == 'Lower House'
    end
  end
end
