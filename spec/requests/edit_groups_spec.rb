require 'spec_helper'

describe "EditGroups" do
  login_user

  before(:each) do
    group = FactoryGirl.create(:group)
    Department.first.groups = [group]
  end

  describe "GET /departments/1/groups/1/edit" do
    it "allows taking a group" do
      get edit_department_group_path(Department.first.id, Group.first.id)
      response.should be_success

      Group.first.taken?.should == false
      response.body.should include 'Edit'
      response.body.should_not include 'Save'

      click_button 'Edit'

      Group.first.taken?.should == true
      Group.first.taken_by_user.should == User.first
      response.body.should_not include 'Edit'
      response.body.should include 'Save'
    end

    it "allows saving a group - untaking" do
      Group.first.take! User.first
      get edit_department_group_path(Department.first.id, Group.first.id)
      pending
      response.status.should be(200)

      click_button 'Save'

      Group.first.taken?.should == false
      response.body.should include 'Edit'
      response.body.should_not include 'Save'
    end

    it "allows saving a group - updating values" do
      get edit_department_group_path(Department.first.id, Group.first.id)
      pending
      response.status.should be(200)
      click_button 'Edit'

      pending
      click_button 'Save'
    end
  end
end
