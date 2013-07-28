class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true

  attr_accessor :current_password

  belongs_to :grade
  has_and_belongs_to_many :roles

  class << self
    def find_or_create_from_auth_hash auth_hash
      @user = self.where(uid: auth_hash.uid, provider: :github).
        first_or_create(email: auth_hash.info.email,
                        password: 666666,
                        password_confirmation: 666666,
                        nickname: auth_hash.info.nickname)
    end

    def calculate_scores
      User.find_each do |user|
        next if user.uid.blank?
        commits = Commit.joins(:project => :grade).where(user_uid: user.uid)

        scores = commits.inject(0) do |sum, commit| 
          weight = commit.project.grade.weights if commit.project

          sum += 1 * weight || 0
        end

        user.update_attributes(score: scores)
      end
    end
  end
end
