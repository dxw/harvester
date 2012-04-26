require 'spec_helper'

describe "EditNeeds" do
  login_user

  before(:each) do
    group = FactoryGirl.create(:group)

    Department.first.groups = [group]

    page = FactoryGirl.create(:page, group_id: group.id)
    need = FactoryGirl.create(:need)

    page.group = group
    page.needs = [need]
  end

  describe "GET /departments/1/needs/1/edit" do
    it "allows taking a need" do
      get edit_department_need_path(Department.first.id, Need.first.id)
      response.should be_success

      Need.first.taken?.should == false
      response.body.should include 'Edit'
      response.body.should_not include 'Save'

      click_button 'Edit'

      Need.first.taken?.should == true
      Need.first.taken_by_user.should == User.first
      response.body.should_not include 'Edit'
      response.body.should include 'Save'
    end
  end
end
