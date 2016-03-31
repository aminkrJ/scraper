module Scraper
  class Engine
    attr_accessor :url

    def initialize(url)
      @url = url
      raise ArgumentError.new("url cannot be blank") if url.nil?
    end

    def visit
      browser = Capybara.current_session
      browser.visit @url
      return browser
    end
  end
end
