require 'spec_helper'

describe User do

  context "should create user by auth_hash" do
    before do
      @auth_hash = double("auth")
      @auth_hash.stub(uid: 123)
      @auth_hash.stub_chain(:info, :email => 'dhh@37signals.com')
      @auth_hash.stub_chain(:info, :nickname => 'DHH')
      @auth_hash.stub_chain(:info, :urls, :GitHub => 'https://github.com/DHH')
    end

    subject{User.find_or_create_from_auth_hash(@auth_hash)}

    its(:uid){should == 123}
    its(:provider){should == :github}
    its(:email){should == 'dhh@37signals.com'}
    its(:nickname){should == 'DHH'}
    it{subject.authenticate('666666').should be_true}

  end

  context "should calculate scores" do
    let!(:grade){ FactoryGirl.create(:grade, name: '无业游民') }
    let!(:repository){ FactoryGirl.create(:repository, name: 'prerequisite') }
    let!(:user){ FactoryGirl.create(:user, score: 0) }

    before do
      FactoryGirl.create(:commit, repository: repository, user_uid: user.uid)
      FactoryGirl.create(:commit, repository: repository, user_uid: user.uid)
    end

    it "score should eq commits.inject(0){(1 * grade.weights)}" do
      User.calculate_scores
      expect(user.reload.score).to eq(2*1*grade.weights)
    end

  end
end
