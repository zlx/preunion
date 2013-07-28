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

  context "should calculate scores" do
    let!(:grade){ FactoryGirl.create(:grade) }
    let!(:user){ FactoryGirl.create(:user, score: 0) }
    let!(:project){ FactoryGirl.create(:project, grade: grade) }

    before do
      FactoryGirl.create(:commit, project: project, user_uid: user.uid)
      FactoryGirl.create(:commit, project: project, user_uid: user.uid)
    end

    it "score should eq commits.inject(0){(1 * commit.project.grade.weights)}" do
      User.calculate_scores
      expect(user.reload.score).to eq(2*1*grade.weights)
    end

  end
end
