class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :website
      t.text :description
      t.integer :grade_id
      t.integer :user_id
      t.date :started_at
      t.date :finished_at
      t.string :status

      t.timestamps
    end

    add_index :projects, :grade_id
    add_index :projects, :user_id
  end
end
