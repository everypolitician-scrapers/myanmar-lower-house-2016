#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'

require_relative 'lib/member_my.rb'
require_relative 'lib/member_en.rb'
require_relative 'lib/member_records'

members_en_url = 'http://api.openhluttaw.org/en/memberships'
members_my_url = 'http://api.openhluttaw.org/my/memberships'
members_en = MemberRecords.new(members_en_url, MemberEN).to_h[:members_of_the_lower_house]
members_my = MemberRecords.new(members_my_url, MemberMY).to_h[:members_of_the_lower_house]

members = members_my.map do |member_my|
  data_en = members_en.find do |member_en|
    member_en.to_h[:id] == member_my.to_h[:id]
  end
  member_my.to_h.merge(data_en.to_h)
end

members.each do |member|
  ScraperWiki.save_sqlite([:id], member.to_h)
end
