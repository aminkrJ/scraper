require 'spec_helper'

describe Scraper::Engine do
  it "returns error when url is blank" do
    expect{ Scraper::Engine.new(nil) }.to raise_error('url cannot be blank')
  end
end
