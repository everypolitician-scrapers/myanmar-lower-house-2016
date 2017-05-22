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

ScraperWiki.sqliteexecute('DROP FROM data') rescue nil

def lower_house_member_records(url, data = [])
  member_records = (scrape url => MemberRecordsPage)
  data += member_records.members_of_the_lower_house.map(&:to_h)

  return data if (next_page = member_records.next).nil?
  lower_house_member_records(next_page, data)
end

start_url = 'http://api.openhluttaw.org/en/memberships'
data = lower_house_member_records(start_url)
data.each { |mem| puts mem.reject { |_, v| v.to_s.empty? }.sort_by { |k, _| k }.to_h } if ENV['MORPH_DEBUG']
ScraperWiki.save_sqlite(%i[id], data)
