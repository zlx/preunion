class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :nickname
      t.integer :grade_id
      t.integer :role_id

      t.timestamps
    end
  end
end
