require 'spec_helper'

describe Page do

  before(:each) do
    @page = FactoryGirl.create(:page)
    FactoryGirl.create(:attr, name: :a)
    FactoryGirl.create(:attr, name: :b)
    FactoryGirl.create(:audience, name: :a)
    FactoryGirl.create(:audience, name: :b)
    FactoryGirl.create(:need, name: :a)
    FactoryGirl.create(:need, name: :b)
  end

  it "set existing attributes, but not create new ones" do
    @page.tags(:attrs).should == []
    @page.set_tags(:attrs, ['a', 'b', 'x', 'y'])
    @page.tags(:attrs).should == ['a', 'b']
  end

  it "set existing and new audiences and needs" do
    @page.tags(:audiences).should == []
    @page.set_tags(:audiences, ['a', 'b', 'x', 'y'])
    @page.tags(:audiences).should == ['a', 'b', 'x', 'y']

    @page.tags(:needs).should == []
    @page.set_tags(:needs, ['a', 'b', 'x', 'y'])
    @page.tags(:needs).should == ['a', 'b', 'x', 'y']
  end

  it "should not be able to set more than one auidence/need" do
    @page.set_tags(:audiences, ['a', 'b', 'a'])
    @page.tags(:audiences).should == ['a', 'b']

    @page.set_tags(:needs, ['b', 'b', 'a'])
    @page.tags(:needs).should == ['b', 'a']
  end

end
