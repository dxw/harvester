require 'spec_helper'

describe "EditGroups" do
  before(:each) do
    user = FactoryGirl.create(:user)
    department = FactoryGirl.create(:department, name: 'Department 1')
    group = FactoryGirl.create(:group, name: 'Group 1')

    user.departments = [department]
    department.groups = [group]

    get '/users/sign_in'
    fill_in 'user_email', with: 'person1@dxw.com'
    fill_in 'user_password', with: 'password1'
    click_button 'Sign in'
  end

  describe "GET /groups/1/edit" do
    it "works! (now write some real specs)" do
      get edit_group_path(Group.first.id)
      response.status.should be(200)
    end
  end
end
