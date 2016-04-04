$: << File.dirname(__FILE__)

require "scraper/version"
require 'capybara/poltergeist'
require 'pry'

require 'scraper/parser'

module Scraper

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end

  Capybara.default_driver = :poltergeist

end


