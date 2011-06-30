require 'spec_helper'

describe "Analysis" do
  context "properties" do
    it "should respond to id" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :id
    end
    
    it "should respond to created_at" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :created_at
    end
    
    it "should respond to updated_at" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :updated_at
    end
    
    it "should respond to md5sum" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :md5sum
    end
    
    it "should respond to regex" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :regex
    end
    
    it "should respond to status" do
      @analysis = Factory.build(:analysis)
      @analysis.should respond_to :status
    end
  end
  
  context "defaults" do
    it "should have false for status" do
      @analysis = Factory.build(:analysis)
      @analysis.status.should == false
    end
  end
  
  context "associations" do
    it "should allow corpuss to be assigned" do
      @analysis = Factory.create(:analysis)
      @corpus = Factory.create(:corpus)
      @analysis.corpuss << @corpus
      @analysis.corpuss.should == [@corpus]
    end
    
    it "should allow fragments to be assigned" do
      @analysis = Factory.create(:analysis)
      @fragment = Factory.create(:fragment)
      @analysis.fragments << @fragment
      @analysis.fragments.should == [@fragment]
    end
  end
  
  context "validations" do
    it "should be valid when straight out of factory" do
      @analysis = Factory.create(:analysis)
      @analysis.should be_valid
    end
    
    it "should be invalid when md5sum is empty" do
      @analysis = Factory.create(:analysis,
        :md5sum => nil
        )
      @analysis.should_not be_valid
    end
    
    it "should be invalid when regex is empty" do
      @analysis = Factory.create(:analysis,
        :regex => nil
        )
      @analysis.should_not be_valid
    end
  end
  
  context "static methods" do
    context "analyse" do
      before(:each) do
        @analysis = SignantiaAnalysis::Analysis.analyse(
          "#{File.dirname(__FILE__)}/fixtures/corpus/1",
          "/[\\S]+/"
          )
      end
      
      it "should return an analysis" do
        @analysis.should be_instance_of(SignantiaAnalysis::Analysis)
      end
      
      it "should tally the correct number of words" do
        @analysis.fragments.sum(:frequency).should == 206
      end
      
      it "should tally the correct number of unique words" do
        @analysis.fragments.count.should == 139
      end
      
      it "should tally the correct frequency of a word" do
        @analysis.fragments.first(:text => "to").frequency.should == 5
      end
      
      it "should set completed status" do
        @analysis.status.should == true
      end
      
      it "should return an existing analysis if it exists" do
        @analysis2 = SignantiaAnalysis::Analysis.analyse(
          "#{File.dirname(__FILE__)}/fixtures/corpus/1",
          "/[\\S]+/"
          )
        @analysis2.should == @analysis
      end
      
      it "should not create more fragments if analysis exists" do
        count = @analysis.fragments.count
        @analysis = SignantiaAnalysis::Analysis.analyse(
          "#{File.dirname(__FILE__)}/fixtures/corpus/1",
          "/[\\S]+/"
          )
        @analysis.reload
        @analysis.fragments.count.should == count
      end
    end
  end
end
