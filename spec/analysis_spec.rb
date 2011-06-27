require 'spec_helper'

describe "Analysis" do
  context "validation" do
    it "should be valid when straight out of factory" do
      @analysis = Factory.create(:analysis)
      @analysis.should be_valid
    end
    
    it "should be invalid when regex is empty" do
      @analysis = Factory.create(:analysis,
        :regex => nil
        )
      @analysis.should_not be_valid
    end
  end
end
