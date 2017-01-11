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
      @json ||= ::JSON.parse(response.body, symbolize_names: true)
    end

    def fragment(mapping)
      json_fragment, klass = mapping.to_a.first
      klass.new(json: json_fragment, response: response)
    end
  end
end
