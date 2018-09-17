# frozen_string_literal: true

require 'json'
require 'field_serializer'
require_relative 'member'

class Members
  include FieldSerializer

  def initialize(url)
    @url = url
  end

  field :members_of_the_lower_house do
    lower_house_members.map do |mem|
      Member.new(mem)
    end
  end

  def json_for(url)
    JSON.parse(open(url).read, symbolize_names: true)
  end

  private

  def lower_house_members
    all_members.select do |mem|
      mem[:organization] && mem[:organization][:classification] == 'Lower House'
    end
  end

  def all_members
    r = []
    current_page = json_for(url)
    r << current_page[:results]
    while current_page[:next]
      current_page = json_for(current_page[:next])
      r << current_page[:results]
    end
    r.flatten
  end

  attr_reader :url
end
