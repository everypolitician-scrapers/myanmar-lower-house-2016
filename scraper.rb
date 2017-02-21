#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'scraperwiki'
require 'scraped'
require 'pry'
require_rel 'lib'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

def scrape(h)
  url, klass = h.to_a.first
  klass.new(response: Scraped::Request.new(url: url).response)
end

ScraperWiki.sqliteexecute('DELETE FROM data') rescue nil

def scrape_lower_house_member_records(url, data = [])
  member_records = (scrape url => MemberRecords)
  data += member_records.members_of_the_lower_house.map(&:to_h)

  return data if (next_page = member_records.next).nil?
  scrape_lower_house_member_records(next_page, data)
end

start_url = 'http://api.openhluttaw.org/en/memberships'
data = scrape_lower_house_member_records(start_url)
# data.each { |d| puts d.reject { |_k, v| v.to_s.empty? }.sort_by { |k, _v| k }.to_h }
ScraperWiki.save_sqlite([:id], data)
