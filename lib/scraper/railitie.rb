module Scraper
  class Railtie < Rails::Railtie
  end
end

require 'scraper/railtie' if defined?(Rails)
