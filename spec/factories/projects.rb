# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    website "MyString"
    description "MyText"
    grade_id 1
    user_id 1
    started_at "2013-07-25"
    finished_at "2013-07-25"
    status "MyString"
  end
end
