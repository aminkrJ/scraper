require 'spec_helper'

describe Scraper::Parser do
  it "returns error when url is blank" do
    expect{ Scraper::Parser.new(nil) }.to raise_error('url cannot be blank')
  end

  describe "parse" do
    let(:url) { "http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/3019/2" }
    it "works!" do
      scraper = Scraper::Parser.new url
      scraper.parse
    end
  end
end
