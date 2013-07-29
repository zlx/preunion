class User < ActiveRecord::Base
  has_secure_password
  validates :email, :nickname, presence: true, uniqueness: true

  attr_accessor :current_password

  belongs_to :grade
  has_and_belongs_to_many :roles
  has_many :projects

  delegate :name, to: :grade, prefix: true, allow_nil: true

  class << self
    def find_or_create_from_auth_hash auth_hash
      @user = self.where(uid: auth_hash.uid, provider: :github).
        first_or_create(email: auth_hash.info.email,
                        github_homepage: auth_hash.info.urls.GitHub,
                        password: 666666,
                        password_confirmation: 666666,
                        nickname: auth_hash.info.nickname)
    end

    def calculate_scores
      User.find_each do |user|
        next if user.uid.blank?
        commits = Commit.joins(:repository).where(user_uid: user.uid)

        scores = commits.inject(0) do |sum, commit| 
          weight = Grade.where(name: Setting.repo_grade[commit.repository.name]).first.try(:weights) if commit.repository

          sum += 1 * (weight || 0)
        end

        user.update_attributes(score: scores)
      end
    end
  end

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=100"
  end

  def graph_commits(days = 7)
    @sizes ||= Commit.where(user_uid: uid).where("commit_date > ?", days.days.ago).group('DATE(commit_date)').size
    (0..days).to_a.inject({}){|a, s| v = s.days.ago.to_date; a[v.to_s(:db)] = @sizes[v]||0; a}
  end
end
