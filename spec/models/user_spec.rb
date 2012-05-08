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

  it "should check if a user can edit the contents of a department" do
    @user1.can_edit_department?(@department1).should be_true
    @user2.can_edit_department?(@department1).should be_false
  end

end
