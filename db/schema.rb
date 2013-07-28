# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130728001524) do

  create_table "commits", force: true do |t|
    t.datetime "commit_date"
    t.string   "committer_name"
    t.string   "committer_email"
    t.string   "html_url"
    t.integer  "repository_id"
    t.string   "sha"
    t.datetime "author_date"
    t.string   "author_name"
    t.string   "author_email"
    t.integer  "user_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "weights"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.integer  "grade_id"
    t.integer  "user_id"
    t.date     "started_at"
    t.date     "finished_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["grade_id"], name: "index_projects_on_grade_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "avatar_url"
    t.string   "description"
    t.string   "html_url"
    t.string   "name"
    t.string   "starred_url"
    t.integer  "uid"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "nickname"
    t.integer  "grade_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.integer  "uid"
  end

end
