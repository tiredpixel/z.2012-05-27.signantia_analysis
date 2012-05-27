require 'spec_helper'

describe "Fragment" do
  context "properties" do
    it "should respond to id" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should respond_to :id
    end
    
    it "should respond to created_at" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should respond_to :created_at
    end
    
    it "should respond to updated_at" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should respond_to :updated_at
    end
    
    it "should respond to text" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should respond_to :text
    end
    
    it "should respond to frequency" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should respond_to :frequency
    end
  end
  
  context "defaults" do
    it "should have 0 for frequency" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.frequency.should == 0
    end
  end
  
  context "validations" do
    it "should be valid when straight out of factory" do
      @fragment = FactoryGirl.build(:fragment)
      @fragment.should be_valid
    end
    
    it "should be invalid without an analysis" do
      @fragment = FactoryGirl.build(:fragment,
        :analysis => nil
        )
      @fragment.should_not be_valid
    end
    
    it "should be invalid when text is empty" do
      @fragment = FactoryGirl.build(:fragment,
        :text => nil
        )
      @fragment.should_not be_valid
    end
  end
end
