require 'spec_helper'

describe Project do

  context "#init_from_commits" do
    let!(:commit) {FactoryGirl.create(:commit)}
    let!(:user) {FactoryGirl.create(:user, uid: commit.user_uid)}
    let!(:repository) {FactoryGirl.create(:repository, id: commit.repository_id)}

    before do
      FactoryGirl.create(:grade, name: '初级')
      Setting.repo_grade = {repository.name => '初级'}
      Project.init_from_commits
    end

    subject{ Project.last }

    its(:name){ should == repository.name }
    its(:user_id) { should == user.id }
    its(:website) { should == repository.html_url }
    its(:description) { should == repository.description }
    its(:grade_name) { should == Setting.repo_grade[repository.name] }
    its(:started_at) { should = commit.commit_date }

    it "should update started_at when has earlier commit" do
      longlong_ago_commit = FactoryGirl.create(:commit, commit_date: 1.year.ago, 
                                               repository_id: repository.id, user_uid: user.uid)

      Project.init_from_commits
      subject.reload.started_at.should == longlong_ago_commit.commit_date.to_date
    end

    it "should set self.project_id when find or create a project" do
      expect(commit.reload.project_id).to eq(subject.id)

    end
  end
end
