require 'spec_helper'

describe PagesController do
  describe 'POST update_multiple' do
    it 'updates values' do
      post :update_multiple, {page_ids: {x: 'y'}}

      response.code.should == '302'
    end
  end
end
