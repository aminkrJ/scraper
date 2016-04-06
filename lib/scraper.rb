$: << File.dirname(__FILE__)

require "scraper/version"
require 'phantomjs'
require 'capybara/poltergeist'
require 'pry'

require 'scraper/parser'

module Scraper

  Phantomjs.path # Force install on require
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs: Phantomjs.path)
  end

  Capybara.default_driver = :poltergeist

end


