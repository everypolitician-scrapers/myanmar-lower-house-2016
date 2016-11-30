require 'scraped'

class Scraped
  class JSON < Scraped
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
