require 'spec_helper'

describe GroupsController do

  describe "GET 'take'" do
    it "returns http success" do
      get 'take'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

end
