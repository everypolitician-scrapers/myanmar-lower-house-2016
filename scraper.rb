#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'
require 'require_all'
require 'scraped_page_archive'

require_rel 'lib'

members_url = 'http://api.openhluttaw.org/en/memberships'

def all_members(url)
  current_members = MembersRecords.new(
    response: Scraped::Request.new(url: url).response
  )
  current_members.members_of_the_lower_house.each do |mem|
    ScraperWiki.save_sqlite([:id, :name], mem.to_h)
  end
  all_members(current_members.next) unless current_members.next.nil?
end

all_members(members_url)
