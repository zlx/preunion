class Commit < ActiveRecord::Base
  belongs_to :repository

  class << self
    def fetch_bay6_commits
      client = Octokit::Client.new(login: Setting.bay6_username, password: Setting.bay6_password)
      client.repos('bay6').each do |repo|
        p repo.id
        fetch_commits_from repo
      end
    end

    def fetch_commits_from repo
      client = Octokit::Client.new(login: Setting.bay6_username, password: Setting.bay6_password)
      local_repo = Repository.find_by(uid: repo.id)
      last_commit = local_repo.commits.order(:commit_date).last || client.commits("#{repo.owner.login}/#{repo.name}").first
      commits = Array.new(100)
      all_commits = []
      begin
        commits = client.commits("#{repo.owner.login}/#{repo.name}", 'master', {per_page: 100, sha: last_commit.sha})
        last_commit = commits.last
        all_commits += commits
      end until commits.count < 100
      all_commits.each{|commit| create_commit(commit, local_repo)}
    end

    def create_commit commit, repo
      author = commit.commit.author
      committer = commit.commit.committer
      self.where(sha: commit.sha).
           first_or_create(user_uid: commit.author.try(:id) || commit.committer.try(:id),
                           author_date: author.date, 
                           author_email: author.email, 
                           commit_date: committer.date,
                           committer_email: committer.email, 
                           committer_name: committer.name, 
                           html_url: commit.html_url, 
                           repository: repo)
    end
  end
end
