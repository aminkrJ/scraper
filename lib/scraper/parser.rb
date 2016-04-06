module Scraper
  class Parser
    attr_accessor :url, :per_serving_unit, :per_serving_amount
    attr_reader :browser, :nutrition_facts
    
    def initialize(url, per_serving_unit: 'grams', per_serving_amount: 100)
      @url = url
      @nutrition_facts = []
      @per_serving_amount = per_serving_amount
      @per_serving_unit = per_serving_unit
      @browser = Capybara.current_session

      #TODO URI.parse
      raise ArgumentError.new("url cannot be blank") if url.nil?
    end

    def parse
      visit_uri

      collect_nutrition_facts_per_serving("#{@per_serving_amount} #{@per_serving_unit}")

      all_nutrition_facts = @browser.all(:xpath, "//*[contains(concat(' ', normalize-space(@class), ' '), ' nf1 ')]/..")
      all_nutrition_facts.collect do |nf|

        name   = nf.find_css('.nf1').first.all_text
        amount = nf.find_css('.nf2').first.all_text
        unit   = nf.find_css('.nf3').first.all_text

        @nutrition_facts << NutritionFact.new(name, amount, unit) if(amount != "~")
      end
    end

    def collect_nutrition_facts_per_serving(serving_amount)
      @browser.select serving_amount, from: 'serving'
    end

    private

    def visit_uri
      @browser.visit @url
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
