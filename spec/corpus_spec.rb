require 'spec_helper'

describe "Corpus" do
  context "properties" do
    it "should respond to id" do
      @corpus = Factory.build(:corpus)
      @corpus.should respond_to :id
    end
    
    it "should respond to created_at" do
      @corpus = Factory.build(:corpus)
      @corpus.should respond_to :created_at
    end
    
    it "should respond to updated_at" do
      @corpus = Factory.build(:corpus)
      @corpus.should respond_to :updated_at
    end
    
    it "should respond to path" do
      @corpus = Factory.build(:corpus)
      @corpus.should respond_to :path
    end
  end
  
  context "associations" do
    it "should allow analyses to be assigned" do
      @corpus = Factory.create(:corpus)
      @analysis = Factory.create(:analysis)
      @corpus.analyses << @analysis
      @corpus.analyses.should == [@analysis]
    end
  end
  
  context "validations" do
    it "should be valid when straight out of factory" do
      @corpus = Factory.build(:corpus)
      @corpus.should be_valid
    end
    
    it "should be invalid when path is empty" do
      @corpus = Factory.build(:corpus,
        :path => nil
        )
      @corpus.should_not be_valid
    end
  end
end
