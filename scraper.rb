#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'require_all'

require_rel 'lib'

members_url = 'http://api.openhluttaw.org/en/memberships'

def scrape_lower_house_members(url)
  records_page = MembershipRecords.new(
    response: Scraped::Request.new(url: url).response
  )
  records_page.members_of_the_lower_house.each do |mem|
    ScraperWiki.save_sqlite([:id, :name], mem.to_h)
  end
  scrape_lower_house_members(records_page.next) unless records_page.next.nil?
end

ScraperWiki.sqliteexecute('DELETE FROM data') rescue nil
scrape_lower_house_members(members_url)
