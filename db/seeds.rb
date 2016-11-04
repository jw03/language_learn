# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name:'khai', last_name:'yong', password:'123', email: 'ky123@1.com')
User.create(first_name:'yong', last_name:'lin', password:'123', email: 'ly123@1.com')
User.create(first_name:'damien', last_name:'lee', password:'123', email: 'dl123@1.com')

Interest.create(name:'Food')
Interest.create(name:'Politic')
Interest.create(name:'Science')
Interest.create(name:'TV Show')
Interest.create(name:'Medicine')
Interest.create(name:'Health')
Interest.create(name:'Beauty')
Interest.create(name:'Religion')

Language.create(name:'English')
Language.create(name:'Espanol')
Language.create(name:'中文')
Language.create(name:'Bahasa')
Language.create(name:'Francais')
