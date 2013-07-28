# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    commit_date "2013-07-24 22:24:59"
    committer_name "MyString"
    committer_email "MyString"
    html_url "MyString"
    repository_id 1
    sha "MyString"
    author_date "2013-07-24 22:24:59"
    author_name "MyString"
    author_email "MyString"
    user_uid 1
    project_id 1
  end
end
