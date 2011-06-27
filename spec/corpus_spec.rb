require 'spec_helper'

describe "Corpus" do
  context "validation" do
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
  
  context "associations" do
    it "should allow textfiles to be assigned" do
      @corpus = Factory.create(:corpus)
      @textfile = Factory.create(:textfile)
      @corpus.textfiles << @textfile
      @corpus.textfiles.should == [@textfile]
    end
    
    it "should allow analyses to be assigned" do
      @corpus = Factory.create(:corpus)
      @analysis = Factory.create(:analysis)
      @corpus.analyses << @analysis
      @corpus.analyses.should == [@analysis]
    end
  end
  
  context "callbacks" do
    it "should register textfiles after save" do
      @corpus = Factory.create(:corpus_with_callbacks)
      @corpus.textfiles.count.should == 3
    end
  end
end
