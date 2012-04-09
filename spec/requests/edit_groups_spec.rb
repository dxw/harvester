require 'spec_helper'

describe "EditGroups" do
  before(:each) do
    user = FactoryGirl.create(:user)
    department = FactoryGirl.create(:department, name: 'Department 1')
    group = FactoryGirl.create(:group, name: 'Group 1')

    user.departments = [department]
    department.groups = [group]

    get new_user_session_path
    fill_in 'user_email', with: 'person1@dxw.com'
    fill_in 'user_password', with: 'password1'
    pending
    click_button 'Sign in'
  end

  describe "GET /groups/1/edit" do
    it "allows taking a group" do
      pending
      get edit_group_path(Group.first.id)
      response.status.should be(200)

      Group.first.taken?.should == false
      response.body.should include 'Take'
      response.body.should_not include 'Save'

      click_button 'Take'

      Group.first.taken?.should == true
      Group.first.taken_by_user.should == User.first
      response.body.should_not include 'Take'
      response.body.should include 'Save'
    end

    it "allows saving a group - untaking" do
      pending
      get edit_group_path(Group.first.id)
      response.status.should be(200)
      click_button 'Take'

      Group.first.taken?.should == true
      Group.first.taken_by_user.should == User.first
      response.body.should_not include 'Take'
      response.body.should include 'Save'

      click_button 'Save'

      Group.first.taken?.should == false
      response.body.should include 'Take'
      response.body.should_not include 'Save'
    end

    it "allows saving a group - updating values" do
      pending
      get edit_group_path(Group.first.id)
      response.status.should be(200)
      click_button 'Take'

      pending
      click_button 'Save'
    end
  end
end
