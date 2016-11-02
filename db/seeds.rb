# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name:'khai', last_name:'yong')
User.create(first_name:'yong', last_name:'lin')
User.create(first_name:'damien', last_name:'lee')
a = User.first
a.interests.create(name:'food')
