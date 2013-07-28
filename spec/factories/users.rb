# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "MyString@#{n}"}
    password 666666
    password_confirmation 666666
    nickname "MyString"
    grade_id 1
    role_id 1
  end
end
