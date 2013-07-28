require 'spec_helper'

describe User do

  context "should create user by auth_hash" do
    before do
      @auth_hash = double("auth")
      @auth_hash.stub(uid: 123)
      @auth_hash.stub_chain(:info, :email => 'dhh@37signals.com')
      @auth_hash.stub_chain(:info, :nickname => 'DHH')
    end

    subject{User.find_or_create_from_auth_hash(@auth_hash)}

    its(:uid){should == 123}
    its(:provider){should == :github}
    its(:email){should == 'dhh@37signals.com'}
    its(:nickname){should == 'DHH'}
    it{subject.authenticate('666666').should be_true}

  end
end
