require "scraper/version"
require 'capybara/poltergeist'

module Scraper

  autoload :Parser, 'Scraper/parser'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end

  Capybara.default_driver = :poltergeist

end


