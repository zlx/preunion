# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    avatar_url "MyString"
    description "MyString"
    html_url "MyString"
    name "MyString"
    starred_url "MyString"
    uid 1
    project_id 1
  end
end
