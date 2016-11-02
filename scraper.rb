#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'

require_relative 'lib/members.rb'

members_url = 'http://api.openhluttaw.org/en/memberships'
members = Members.new(members_url).to_h[:members_of_the_lower_house]

members.each do |member|
  ScraperWiki.save_sqlite([:id], member.to_h)
end
