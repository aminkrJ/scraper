module Scraper
  class Parser
    attr_accessor :browser

    def initialize(browser)
      @browser = browser
    end

    def parse
      @browser.select '100 grams', from: 'serving'
      collect_nutrition_facts
    end

    def collect_nutrition_facts
    end
  end
end
