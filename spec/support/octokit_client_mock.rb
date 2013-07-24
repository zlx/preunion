GRepo = Struct.new(:id, :name, :description, :owner, :html_url)
GOwner = Struct.new(:id, :avatar_url, :starred_url, :date, :login, :email, :name)
GCommit = Struct.new(:author, :committer, :commit, :html_url, :sha)

module Octokit
  class Client
    def initialize options
      owner = GOwner.new(1, 'avator_url', 'starred_url', Time.now, 'name', 'email', 'name')
      @repos = [GRepo.new(100, 'repo', 'mock repo', owner, 'html_url')]
      @commits = [GCommit.new(owner, owner, GCommit.new(owner, owner, '', 'html_url', ''), 'html_url', 'ssssss')]
    end

    def repos repo_name
      @repos
    end

    def commits repo, branch = 'master', options = {}
      @commits
    end
  end
end
