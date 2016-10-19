#!/bin/env ruby
# encoding: utf-8
require 'scraperwiki'
require 'colorize'
require 'combine_popolo_memberships'

require_relative 'lib/members.rb'

members_url = 'http://api.openhluttaw.org/en/memberships'
members = Members.new(members_url).to_a
puts "Found #{members.count} members"
