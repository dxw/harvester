require 'spec_helper'

describe PagesController do
  describe 'POST update_multiple' do
    before(:each) do
      %w[cit biz bl spec wh ret].each do |a|
        FactoryGirl.create(:attribute, name: a)
      end
      @pages = []
      @pages << FactoryGirl.create(:page)
      @pages << FactoryGirl.create(:page)
    end

    it 'updates values' do
      post :update_multiple, {
        pages: {
          @pages.first.id => {
            attributes: ['cit', 'biz'],
            audiences: ['tom', 'your cat'],
            needs: ['biscuits', 'gravy']
          },
          @pages.second.id => {
            attributes: ['bl', 'spec'],
            audiences: ['a cute dog'],
            needs: ['treats', 'lovin\'']
          }
        }
      }

      response.code.should == '302'

      Page.all.length.should == 2
      Page.all.first.attributes.map {|a| a.name }.should == ['cit', 'biz']
      Page.all.first.audiences.map {|a| a.name }.should == ['tom', 'your cat']
      Page.all.first.needs.map {|a| a.name }.should == ['biscuits', 'gravy']

      Page.all.second.attributes.map {|a| a.name }.should == ['bl', 'spec']
      Page.all.second.audiences.map {|a| a.name }.should == ['a cute dog']
      Page.all.second.needs.map {|a| a.name }.should == ['treats', 'lovin\'']
    end
  end
end
