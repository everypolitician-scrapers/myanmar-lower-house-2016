# frozen_string_literal: true
require_relative './test_helper'
require_relative '../lib/member_records'

describe MemberRecords do
  around { |test| VCR.use_cassette(File.basename(url), &test) }

  let(:yaml_data) { YAML.load_file(subject) }
  let(:url) { yaml_data[:url] }
  let(:response) { MemberRecords.new(response: Scraped::Request.new(url: url).response) }

  describe 'member data' do
    let(:subject) { 'test/data/YanLin.yml' }

    it 'should match the test data' do
      response.members_of_the_lower_house.first.to_h.must_equal yaml_data[:to_h]
    end
  end

  describe 'member with phone number and alternate names' do
    let(:subject) { 'test/data/AungNaing.yml' }

    it 'should match the test data' do
      response.members_of_the_lower_house.find { |mem| mem.id == '70511a1c7d014ab4add384536237c63b' }
              .to_h.must_equal yaml_data[:to_h]
    end
  end
end
