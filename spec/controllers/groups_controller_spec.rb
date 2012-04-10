require 'spec_helper'

describe GroupsController do
  login_user

  before(:each) do
    @groups = []
    @groups << FactoryGirl.create(:group, name: 'Group1')
    @groups << FactoryGirl.create(:group, name: 'Group2')
  end

  describe "POST 'update'" do
    it "allows taking groups" do
      pending
      post 'update', {id: @groups.first.to_param, commit: 'Take'}
      p subject.current_user
      response.should be_redirect
      response.headers['Location'].should == "http://test.host/groups/#{@groups.first.id}/edit"

      @groups.first.taken?.should be_true
      @groups.first.taken_by_user.should_not be_nil
      response.should be_redirect
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
