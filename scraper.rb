#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'

require_relative 'lib/members.rb'

members_en_url = 'http://api.openhluttaw.org/en/memberships'
members_my_url = 'http://api.openhluttaw.org/my/memberships'
members_en = Members.new(members_en_url).to_h[:members_of_the_lower_house]
members_my = Members.new(members_my_url).to_h[:members_of_the_lower_house]

members = members_my.map do |member|
  data = member.to_h
  member_en = members_en.find do |member_en|
    member_en.to_h[:id] == data[:id]
  end
  data[:name__en] = member_en.to_h[:name]
  data[:name__my] = data[:name]
  data[:alternate_names__en] = member_en.to_h[:alternate_names]
  data[:alternate_names__my] = data[:alternate_names]
  data[:party__en] = member_en.to_h[:party]
  data[:party__my] = data[:party]
  data
end

members.each do |member|
  ScraperWiki.save_sqlite([:id], member.to_h)
end
