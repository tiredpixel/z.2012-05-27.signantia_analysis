require 'spec_helper'

describe "User" do
  it "should be valid when straight out of factory" do
    @user = Factory.build(:user)
    @user.should be_valid
  end
  
  it "should be invalid when email is empty" do
    @user = Factory.build(:user, :email => nil)
    @user.should_not be_valid
  end
  
  it "should be invalid when email is not an email address" do
    @user = Factory.build(:user, :email => "invalid_email")
    @user.should_not be_valid
  end
  
  it "should be invalid when email is not unique" do
    @user1 = Factory.create(:user)
    @user2 = Factory.build(:user, :email => @user1.email)
    @user2.should_not be_valid
  end
  
  it "should be invalid when password is empty" do
    @user = Factory.build(:user, :password => nil, :password_hash => nil)
    @user.should_not be_valid
  end
  
  it "should set hash password correctly" do
    @password = "test password"
    @user = Factory.build(:user, :password => @password)
    @user.password.should == @password
  end
  
  it "should generate a confirmation key correctly" do
    @user = Factory.build(:user)
    @key = @user.generate_confirmation_key
    @user.confirmation_key.should == @key
  end
  
  it "should confirm when forced to" do
    @user = Factory.build(:user)
    @user.confirmed.should == false
    @user.confirm!
    @user.confirmed.should == true
  end
end
