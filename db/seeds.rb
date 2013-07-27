# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# set admin user
role = Role.find_or_create_by(name: 'admin')
User.where(name: 'admin', email: 'admin@example').
     first_or_create(password: 'password', password_confirmation: 'password', roles: [role])

# setting bay6 github username and password
Setting.bay6_username = 'ken0'
Setting.bay6_password = 'password9'

# set project grade
Grade.where(name: '无业游民').first_or_create(weights: 1)
Grade.where(name: '初级').first_or_create(weights: 2)
Grade.where(name: '中级').first_or_create(weights: 4)
Grade.where(name: '高级').first_or_create(weights: 8)

# save repo grade for union project
# repo not in the group will ignored, ex: ajaxful-rating, devise_omniauth_github
# ignore the group:
# rake task github:fetch_repos
# rake task github:fetch_commits
# care the group:
# other not in ignore the group 
#
Setting.repo_grade = {'books-share' => '高级',  'interview_zen' => '中级',
                      'jquery_resume' => '初级', 'lazyload_image' => '中级',
                      'omniauth-github-example' => '初级', 'portal' => '高级',
                      'prepare' => '初级', 'prerequisite' => '无业游民',
                      'preunion' => '初级', 'railscasts_assistant' => '初级',
                      'rails_angularjs' => '初级', 'rank_of_github' => '中级',
                      'rank_of_github2' => '中级', 'union' => '高级'}
