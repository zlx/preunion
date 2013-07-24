class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :avatar_url
      t.string :description
      t.string :html_url
      t.string :name
      t.string :starred_url
      t.integer :uid
      t.integer :project_id

      t.timestamps
    end
  end
end
