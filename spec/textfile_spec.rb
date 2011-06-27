require 'spec_helper'

describe "Textfile" do
  context "validation" do
    it "should be valid when straight out of factory" do
      @textfile = Factory.build(:textfile)
      @textfile.should be_valid
    end
    
    it "should be invalid when path is empty" do
      @textfile = Factory.build(:textfile,
        :path => nil
        )
      @textfile.should_not be_valid
    end
    
    it "should set md5sum correctly" do
      @textfile = Factory.create(:textfile)
      @textfile.md5sum.should == Digest::MD5.hexdigest(@textfile.path.read)
    end
    
    it "should be invalid with a corpus" do
      @textfile = Factory.build(:textfile,
        :corpus => nil
        )
      @textfile.should_not be_valid
    end
    
    it "should be invalid with duplicate corpus, path" do
      @textfile = Factory.create(:textfile)
      @textfile2 = Factory.build(:textfile,
        :corpus => @textfile.corpus,
        :path => @textfile.path
        )
      @textfile2.should_not be_valid
    end
    
    it "should be valid with duplicate path, not corpus" do
      @textfile = Factory.create(:textfile)
      @textfile2 = Factory.build(:textfile,
        :path => @textfile.path
        )
      @textfile2.should be_valid
    end
    
    it "should be valid with duplicate corpus, not path" do
      @textfile = Factory.create(:textfile)
      @textfile2 = Factory.build(:textfile,
        :corpus => @textfile.corpus,
        :path => "#{File.dirname(__FILE__)}/fixtures/corpus/2"
        )
      @textfile2.should be_valid
    end
  end
end
