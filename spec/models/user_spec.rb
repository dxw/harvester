require 'spec_helper'

describe User do

  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @department1 = FactoryGirl.create(:department)
    @group1 = FactoryGirl.create(:group)
    @department1.groups = [@group1]
    @department1.users = [@user1]

    @user2 = FactoryGirl.create(:user)
    @department2 = FactoryGirl.create(:department)
    @group2 = FactoryGirl.create(:group)
    @department2.groups = [@group2]
    @department2.users = [@user2]
  end

  it "should return its groups" do
    @user1.groups.should include(@group1)
    @user2.groups.should include(@group2)
  end

  it "should not return somebody else's groups" do
    @user1.groups.should_not include(@group2)
    @user2.groups.should_not include(@group1)
  end

end
