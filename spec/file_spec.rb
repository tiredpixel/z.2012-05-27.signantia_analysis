require 'spec_helper'

describe "File" do
  context "validation" do
    it "should be valid when straight out of factory" do
      @file = Factory.build(:file)
      @file.should be_valid
    end
    
    it "should be invalid when path is empty" do
      @file = Factory.build(:file,
        :path => nil
        )
      @file.should_not be_valid
    end
    
    it "should set md5sum correctly" do
      @file = Factory.create(:file)
      @file.md5sum.should == Digest::MD5.hexdigest(@file.path.read)
    end
    
    it "should be invalid with a corpus" do
      @file = Factory.build(:file,
        :corpus => nil
        )
      @file.should_not be_valid
    end
  end
end
