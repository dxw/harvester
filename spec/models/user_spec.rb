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

  it "should return the next group available" do
    a = FactoryGirl.create(:group, name: 'Swede')
    FactoryGirl.create(:page_with_attributes, group_id: a.id)
    b = FactoryGirl.create(:group, name: 'Rutabaga')
    FactoryGirl.create(:page, group_id: b.id)
    @department1.groups = [a, b]

    @user1.next_group.should == b
  end

  it "should not return a group the user can't edit" do
    a = FactoryGirl.create(:group, name: 'Swede')
    FactoryGirl.create(:page_with_attributes, group_id: a.id)
    b = FactoryGirl.create(:group, name: 'Rutabaga')
    FactoryGirl.create(:page, group_id: b.id)

    @user1.next_group.should be_nil
  end

  it "should check if a user can edit a group" do
    @user1.can_edit?(@group1).should be_true
    @user2.can_edit?(@group1).should be_false
  end

end
