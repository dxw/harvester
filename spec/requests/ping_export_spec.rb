require 'spec_helper'

describe "PingExport" do
  login_user

  before(:each) do
    @exported_data = FactoryGirl.create(:exported_data)
  end

  describe "GET /export/ping/:id" do
    it "reports a waiting ExportedData is waiting" do
      get ping_export_path(@exported_data.id)
      response.should be_success

      res = JSON.load(response.body)

      res['waiting'].should be_true
    end

    it "reports a completed ExportedData is complete" do
      @exported_data.uri = 'http://dxw.com/'
      @exported_data.save!
      get ping_export_path(@exported_data.id)
      response.should be_success

      res = JSON.load(response.body)

      res['waiting'].should_not be_true
      res['uri'].should == @exported_data.uri
    end
  end
end
