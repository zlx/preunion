class AddGithubHomepageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_homepage, :string
  end
end
