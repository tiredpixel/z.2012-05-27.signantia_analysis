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
  
  context "instance methods" do
    context "analyse" do
      before(:each) do
        @corpus = Factory.create(:corpus)
        @corpus.analyse("/[\\S]+/")
      end
      
      it "should have the correct number of analyses" do
        @corpus.analyses.count.should == 3
      end
      
      it "should have the correct md5sums for analyses" do
        @corpus.analyses.map(&:md5sum).should =~ [
          "4a86398dc8018165493f3e984f4ab7fc",
          "5bae6e908ab1f5e024c784f95e4f1bd8",
          "302be1af153a7a02ae783be1b1a24b9a"
          ]
      end
      
      it "should have the correct regex for analyses" do
        @corpus.analyses.map(&:regex).each do |r|
          r.should == "/[\\S]+/"
        end
      end
      
      it "should tally the correct number of fragments" do
        @corpus.analyses(:regex => "/[\\S]+/").fragments.count.should == 143
      end
      
      it "should tally the correct frequency of a word across files" do
        @corpus.analyses(:regex => "/[\\S]+/").fragments(:text => "I").sum(:frequency).should == 3
      end
    end
  end
end
