# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    password_hash "MyString"
    nickname "MyString"
    grade_id 1
    role_id ""
  end
end
