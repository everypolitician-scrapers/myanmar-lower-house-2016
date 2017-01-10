require 'open-uri'
require 'open-uri/cached'
require 'json'
require_relative 'membership_record'

OpenURI::Cache.cache_path = '.cache'

class MembershipRecords < Scraped::JSON
  field :members_of_the_lower_house do
    lower_house_members.map do |mem|
      fragment mem => MembershipRecord
    end
  end

  field :next do
    json[:next]
  end

  def json_for(url)
    JSON.parse(open(url).read, symbolize_names: true)
  end

  private

  def lower_house_members
    json[:results].select do |mem|
      mem[:organization][:classification] == 'Lower House'
    end
  end
end
