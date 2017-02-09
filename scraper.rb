#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'scraperwiki'

require_relative 'lib/members.rb'

members_url = 'http://api.openhluttaw.org/en/memberships'
members = Members.new(members_url).to_h[:members_of_the_lower_house]

members.each do |member|
  ScraperWiki.save_sqlite([:id], member.to_h)
end
