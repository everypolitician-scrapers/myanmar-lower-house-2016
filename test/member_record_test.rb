# frozen_string_literal: true
require_relative './test_helper'
require_relative '../lib/members'

describe Members do
  around { |test| VCR.use_cassette(File.basename(url), &test) }

  let(:yaml_data) { YAML.load_file(subject) }
  let(:url) { yaml_data[:url] }
  let(:response) { Members.new(url) }

  describe 'member data' do
    let(:subject) { 'test/data/YanLin.yml' }

    it 'should match the test data' do
      response.members_of_the_lower_house.first.to_h.must_equal yaml_data[:to_h]
    end
  end
end