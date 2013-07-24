require 'spec_helper'

describe Commit do

  context "github:fetch_commit task" do
    let(:repo){FactoryGirl.create(:repository)}
    let(:gowner){GOwner.new(1, :avatar_url, :starred_url, Time.now, :login, :email, :name)}
    let(:grepo){GRepo.new(repo.uid, 'repo', 'mock repo', gowner, 'html_url')}
    let(:gcommit){GCommit.new(gowner, gowner, GCommit.new(gowner, gowner, '', 'html_url', 'ssss'), 'html_url', 'ssss')}

    it "#fetch_bay6_commits" do
      Commit.should_receive(:fetch_commits_from)
      Commit.fetch_bay6_commits
    end

    it "#fetch_commits_from" do
      Commit.should_receive(:create_commit)
      Commit.fetch_commits_from grepo
    end

    it "#create_commit" do
      Commit.create_commit gcommit, repo
      Commit.count.should == 1
    end
  end
end
