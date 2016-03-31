module Scraper
  class Parser
    attr_accessor :url
    attr_reader :browser

    def initialize(url)
      @url = url
      raise ArgumentError.new("url cannot be blank") if url.nil?
    end

    def parse
      @browser = Capybara.current_session
      @browser.visit @url
      collect_nutrition_facts
    end

    def collect_nutrition_facts
      @browser.select '100 grams', from: 'serving'
    end
  end
end
