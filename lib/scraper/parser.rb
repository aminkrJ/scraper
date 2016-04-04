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

      collect_nutrition_facts_per_serving("100 grams")

      all_nutrition_facts = @browser.all(:xpath, "//*[contains(concat(' ', normalize-space(@class), ' '), ' nf1 ')]/..")
      all_nutrition_facts.collect do |nf|
        name = nf.find_css('.nf1').first.all_text
        amount = nf.find_css('.nf2').first.all_text
        unit = nf.find_css('.nf3').first.all_text
        NutritionFact.new(name, amount, unit) if amount != "~"
      end
      return { per_serving_amount: "100", per_serving_unit: 'g', nutrition_facts: all_nutrition_facts }
    end

    def collect_nutrition_facts_per_serving(amount)
      @browser.select amount, from: 'serving'
    end
  end

  class NutritionFact
    attr_accessor :name, :amount, :unit

    def initialize(name, amount, unit)
      @name   = name.strip.downcase
      @amount = amount.strip

      # unit can be wrong. following is to handle edge cases.
      wrong_unit = unit.strip.downcase
      @unit = wrong_unit.tr("^A-Za-z", "")
      @amount = wrong_unit.scan(/(\d+[,.]\d+)/).flatten.first unless wrong_unit.tr("^0-9", "").empty?
    end
  end
end
