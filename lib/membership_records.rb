# frozen_string_literal: true
require 'json'
require_relative 'membership_record'

class MembershipRecords < Scraped::JSON
  field :members_of_the_lower_house do
    lower_house_members.map do |mem|
      fragment mem => MembershipRecord
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
