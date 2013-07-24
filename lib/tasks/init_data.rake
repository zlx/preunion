namespace :github do
  task :init => :environment do
    Rake::Task["github:fetch_repos"].invoke
    Rake::Task["github:fetch_commits"].invoke
  end

  task :fetch_repos => :environment do
    Repository.init_from_github
  end

  task :fetch_commits => :environment do
    Commit.fetch_bay6_commits
  end
end
