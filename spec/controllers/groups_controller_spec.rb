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
      response.should be_redirect
      response.headers['Location'].should == "http://test.host/departments/1/groups/#{@group1.id}/edit"

      @group1.taken?.should be_true
      @group1.taken_by_user.should == @user
    end

    it "allows untaking groups" do
      pending
      @groups.first.taken_by = @users.first.id

      post 'update', {id: @groups.first.id, commit: 'Save'}

      @groups.first.taken?.should be_false
      @groups.first.taken_by_user.should == @users.first.id
      response.should be_redirect
    end

    it "allows updating values" do
      pending
      post 'update', group: {id: @groups.first.id, commit: true}

      @groups.first.taken?.should be_true
      @groups.first.taken_by_user.should_not be_nil
      response.should be_redirect
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      pending
      get 'edit'
      response.should be_success
      pending
    end
  end

end
