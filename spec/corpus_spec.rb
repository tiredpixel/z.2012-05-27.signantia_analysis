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
    it "should allow files to be assigned" do
      @corpus = Factory.create(:corpus)
      @file = Factory.create(:file)
      @corpus.files << @file
      @corpus.files.should == [@file]
    end
  end
  
  context "callbacks" do
    it "should register files after save" do
      @corpus = Factory.create(:corpus_with_callbacks)
      @corpus.files.count.should == 3
    end
  end
end
