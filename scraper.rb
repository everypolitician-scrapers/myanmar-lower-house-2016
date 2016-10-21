#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'

require_relative 'lib/lower_house_members.rb'

members_url = 'http://api.openhluttaw.org/en/memberships'
members = LowerHouseMembers.new(members_url).to_a

members.map do |member|
  ScraperWiki.save_sqlite([:id], member)
end
