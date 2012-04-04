require 'spec_helper'

describe GroupsController do
  login_user

  before(:each) do
    @groups = []
    @groups << FactoryGirl.create(:group, name: 'Group1')
    @groups << FactoryGirl.create(:group, name: 'Group2')
  end

  describe "POST ':id/take'" do
    it "allows taking groups" do
      post 'take', id: @groups.first.id

      @groups.first.taken?.should be_true
      @groups.taken_by_user.should_not be_nil
      response.should be_redirect
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
      pending
    end
  end

end
