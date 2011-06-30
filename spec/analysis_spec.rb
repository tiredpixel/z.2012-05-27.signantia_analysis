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
    
    it "should be invalid when md5sum wrong length" do
      [(1..31), (33..100)].each do |r|
        r.each do |i|
          @analysis = Factory.build(:analysis,
          :md5sum => "A" * i
          )
          @analysis.should_not be_valid
        end
      end
    end
    
    it "should be invalid when regex is empty" do
      @analysis = Factory.create(:analysis,
        :regex => nil
        )
      @analysis.should_not be_valid
    end
  end
end
