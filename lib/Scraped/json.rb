require 'scraped'

module Scraped
  class JSON < Scraped::Document
    require 'json'

    private

    def initialize(json: nil, **args)
      super(**args)
      @json = json
    end

    def json
      @json ||= ::JSON.parse(Nokogiri::HTML(response.body), symbolize_names: true)
    end
  end
end
