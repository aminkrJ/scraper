require 'spec_helper'

describe Scraper::Parser do
  it "returns error when url is blank" do
    expect{ Scraper::Parser.new(nil) }.to raise_error('url cannot be blank')
  end

  describe "parse" do
    it "creates fixture" do
      VCR.use_cassette('nutrition_facts') do
        response = Net::HTTP.get_response(URI("http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/3019/2"))
        expect(response.body).to match(/Squash, zucchini, baby, raw/)
      end
    end
  end
end
