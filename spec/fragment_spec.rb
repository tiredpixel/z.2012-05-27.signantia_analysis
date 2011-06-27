require 'spec_helper'

describe "Fragment" do
  context "validation" do
    it "should be valid when straight out of factory" do
      @fragment = Factory.build(:fragment)
      @fragment.should be_valid
    end
    
    it "should be invalid when text is empty" do
      @fragment = Factory.build(:fragment,
        :text => nil
        )
      @fragment.should_not be_valid
    end
    
    it "should be invalid without a corpus" do
      @fragment = Factory.build(:fragment,
        :corpus => nil
        )
      @fragment.should_not be_valid
    end
    
    it "should be invalid without an analysis" do
      @fragment = Factory.build(:fragment,
        :analysis => nil
        )
      @fragment.should_not be_valid
    end
  end
end
