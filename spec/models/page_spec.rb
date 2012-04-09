require 'spec_helper'

describe Page do

  before(:each) do
    @page = FactoryGirl.create(:page)
    FactoryGirl.create(:attribute, name: :a)
    FactoryGirl.create(:attribute, name: :b)
    FactoryGirl.create(:audience, name: :a)
    FactoryGirl.create(:audience, name: :b)
    FactoryGirl.create(:need, name: :a)
    FactoryGirl.create(:need, name: :b)
  end

  it "set existing attributes, but not create new ones" do
    @page.tags(:attributes).should == []
    @page.set_tags(:attributes, ['a', 'b', 'x', 'y'])
    @page.tags(:attributes).should == ['a', 'b']
  end

  it "set existing and new audiences and needs" do
    @page.tags(:audiences).should == []
    @page.set_tags(:audiences, ['a', 'b', 'x', 'y'])
    @page.tags(:audiences).should == ['a', 'b', 'x', 'y']

    @page.tags(:needs).should == []
    @page.set_tags(:needs, ['a', 'b', 'x', 'y'])
    @page.tags(:needs).should == ['a', 'b', 'x', 'y']
  end

end
