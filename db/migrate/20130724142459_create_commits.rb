class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.datetime :commit_date
      t.string :committer_name
      t.string :committer_email
      t.string :html_url
      t.integer :repository_id
      t.string :sha
      t.datetime :author_date
      t.string :author_name
      t.string :author_email
      t.integer :user_uid

      t.timestamps
    end
  end
end
