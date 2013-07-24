# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# set admin user
#User.where(name: 'admin', email: 'admin@example').
     #first_or_create(password: 'password', password_confirmation: 'password')

# setting bay6 github username and password

Setting.bay6_username = 'ken0'
Setting.bay6_password = 'password9'


Repository.init_from_github

