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
  r = []
  current_page = MembersRecords.new(
    response: Scraped::Request.new(url: url).response
  )
  r << current_page.members_of_the_lower_house
  while current_page.next
    current_page = MembersRecords.new(
      response: Scraped::Request.new(url: current_page.next).response
    )
    r << current_page.members_of_the_lower_house
  end
  r.flatten
end

all_members(members_url).each do |member|
  ScraperWiki.save_sqlite([:id, :name], member.to_h)
end
