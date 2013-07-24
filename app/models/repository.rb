class Repository < ActiveRecord::Base
  has_many :commits

  class << self
    def init_from_github
      client = Octokit::Client.new(login: Setting.bay6_username, password: Setting.bay6_password)
      client.repos('bay6').each do |repo|
        self.where(uid: repo.id).first_or_create(name: repo.name, avatar_url: repo.owner.avatar_url,
                                                 description: repo.description, html_url: repo.html_url,
                                                 starred_url: repo.owner.starred_url)

      end
    end
  end
end
