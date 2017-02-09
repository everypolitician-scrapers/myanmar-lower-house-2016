#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'scraperwiki'

require_relative 'lib/members.rb'

members_url = 'http://api.openhluttaw.org/en/memberships'

ScraperWiki.sqliteexecute('DELETE FROM data') rescue nil
data = Members.new(members_url).members_of_the_lower_house.map(&:to_h)
ScraperWiki.save_sqlite([:id], data)
