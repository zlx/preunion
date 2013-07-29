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

  context "should return commits data for graph" do
    let!(:user) {FactoryGirl.create(:user)}
    before do
      FactoryGirl.create(:commit, commit_date: 2.days.ago, user_uid: user.uid)
      FactoryGirl.create(:commit, commit_date: 3.days.ago, user_uid: user.uid)
      FactoryGirl.create(:commit, commit_date: 2.days.ago, user_uid: user.uid)
    end

    subject { user.graph_commits }

    it{should be_a_kind_of(Hash)}
    its(:length){should == 8}
    it{subject[2.days.ago.to_date.to_s(:db)].should == 2}
    it{subject[3.days.ago.to_date.to_s(:db)].should == 1}
    it{subject[1.days.ago.to_date.to_s(:db)].should == 0}

    it "should return more result when pass days" do
      expect(user.graph_commits(100).length).to eq 100 + 1
    end

  end
end
