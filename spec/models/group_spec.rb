require 'spec_helper'

describe Group do

  it "should return the next group available" do
    a = FactoryGirl.create(:group, name: 'Swede')
    FactoryGirl.create(:page_with_attributes, group_id: a.id)
    b = FactoryGirl.create(:group, name: 'Rutabaga')
    FactoryGirl.create(:page, group_id: b.id)

    Group.next.should == b
  end

  it "should allow itself to be taken" do
    g1 = FactoryGirl.create(:group, name: 'Potato')
    g2 = FactoryGirl.create(:group, name: 'Head')
    d = FactoryGirl.create(:department)
    u = FactoryGirl.create(:user)

    d.groups << g1
    d.users << u

    expect { g1.take! u }.to_not raise_error
    expect { g2.take! u }.to raise_error
  end

end
