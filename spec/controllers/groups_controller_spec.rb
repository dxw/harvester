require 'spec_helper'

describe GroupsController do
  login_user

  before(:each) do
    # @user1 = FactoryGirl.create(:user)
    @department1 = FactoryGirl.create(:department)
    @group1 = FactoryGirl.create(:group)
    @department1.groups = [@group1]
    @department1.users = [@user]
    [1,2,3].each do |i|
      pg = FactoryGirl.create(:page, group_id: @group1.id)
      pg.needs << FactoryGirl.create(:need, name: "N#{i}")
    end

    @user2 = FactoryGirl.create(:user)
    @department2 = FactoryGirl.create(:department)
    @group2 = FactoryGirl.create(:group)
    @department2.groups = [@group2]
    @department2.users = [@user2]
  end

  describe "POST 'update'" do
    it "allows taking groups" do
      post 'update', {department_id: @department1.to_param, id: @group1.to_param, commit: 'Take'}

      @group1.taken?.should be_true
      @group1.taken_by_user.should == @user
      response.should redirect_to(edit_department_group_path(department_id: @department1.to_param, id: @group1.to_param))
    end

    it "allows untaking groups" do
      @group1.taken_by = @user.id

      post 'update', {department_id: @department1.to_param, id: @group1.to_param, commit: 'Save'}

      @group1.taken?.should be_false
      @group1.taken_by_user.should == @user.id
      response.should redirect_to(edit_department_group_path(department_id: @department1.to_param, id: @group1.to_param))
    end

    it "allows updating values" do
      pending
      post 'update', group: {department_id: @department1.to_param, id: @group1.to_param, commit: 'Save'}

      response.should redirect_to(edit_department_group_path(department_id: @department1.to_param, id: @group1.to_param))
      @group1.taken?.should be_true
      @group1.taken_by_user.should_not be_nil
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', {department_id: @department1.to_param, id: @group1.to_param}
      response.should be_success
    end

    it "redirects non-users elsewhere" do
      get 'edit', {department_id: @department2.to_param, id: @group2.to_param}
      response.should redirect_to(department_groups_path)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', {department_id: @department1.to_param}
      response.should be_success
    end
  end

end
