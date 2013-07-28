namespace :github do
  task :init => :environment do
    Rake::Task["github:fetch_repos"].invoke
    Rake::Task["github:fetch_commits"].invoke
    Rake::Task["github:init_projects"].invoke
    Rake::Task["github:calculate_scores"].invoke
  end

  task :fetch_repos => :environment do
    Repository.init_from_github
  end

  task :fetch_commits => :environment do
    Commit.fetch_bay6_commits
  end

  task :init_projects => :environment do
    Project.init_from_commits
  end

  task :calculate_scores => :environment do
    User.calculate_scores
  end

  desc "init users only for development"
  task :init_users => :environment do
    users = Commit.select('distinct committer_email, user_uid')
    users.each do |user|
      next if user.user_uid.blank?
      User.where(uid: user.user_uid).first_or_create(email: user.committer_email, 
                                                     password: 666666, 
                                                     password_confirmation: 666666,
                                                     nickname: user.committer_email[/(.*)@/, 1], 
                                                     provider: :github, 
                                                     github_homepage: 'https://github.com/' + user.committer_email)
    end
  end
end
