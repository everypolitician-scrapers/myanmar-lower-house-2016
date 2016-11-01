require 'open-uri'
require 'open-uri/cached'
require 'json'
require_relative 'member_formatter'

OpenURI::Cache.cache_path = '.cache'

class Members
  def initialize(url)
    @url = url
  end

  def to_a
    mems.map do |mem|
      Member.new(mem).to_h
    end
  end

  def json_for(url)
    JSON.parse(open(url).read, symbolize_names: true)
  end

  private

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
