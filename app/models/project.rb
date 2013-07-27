class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :grade

  delegate :name, to: :grade, allow_nil: true, prefix: true

  class << self
    def init_from_commits
      Commit.find_each do |commit|
        user = User.where('uid is not null').where(uid: commit.user_uid).first
        grade = Setting.repo_grade[commit.repository.name] if commit.repository.present?
        next if user.blank? || (repo = commit.repository).blank? || grade.blank?

        project = Project.where(name: repo.name, user_id: user.id).
                          first_or_create(website: repo.html_url, description: repo.description, grade: Grade.where(name: grade).first)

        if project.started_at.blank? || project.started_at > commit.commit_date.to_date
          project.update_attributes(started_at: commit.commit_date)
        end
      end
    end
  end
end
