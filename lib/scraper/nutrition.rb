module Scraper
  class Nutrition
    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def gather
      browser = Capybara.current_session
      browser.visit @url

      browser.select '100 grams', from: 'serving'
    end
  end
end
