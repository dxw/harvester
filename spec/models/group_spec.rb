require 'spec_helper'

describe Group do

  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @dept1 = FactoryGirl.create(:department)
    @dept1.users = [@user1]
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
