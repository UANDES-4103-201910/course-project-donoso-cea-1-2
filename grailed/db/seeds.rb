# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u3 = User.new(name:'Administrador', lastname:'General', 
              password:'123456', password_confirmation:'123456', email:'admin@uandes.cl', 
              role:'admin',city: 'Santiago', country: 'Chile',bio:'el mas bacan de los admins')

u4 = User.new(name:'Normal', lastname:'User', 
              password:'123456', password_confirmation:'123456', email:'normal_user@uandes.cl', 
              role:'normal',city: 'Santiago', country: 'Chile',bio:'el mas bacan de los users')

u5 = User.new(name:'Normal2', lastname:'User2', 
              password:'123456', password_confirmation:'123456', email:'normal_user@uandes.cl', 
              role:'normal',city: 'Santiago', country: 'Chile',bio:'el mas bacan de los users')



p1 = Post.new(description: 'Hola soy un usuario de esta pàgina web', user_id: 1)

p2 = Post.new(description: 'Hola soy un usuario de esta pàgina web', user_id: 2)

p3 = Post.new(description: 'Hola soy un usuario de esta pàgina web', user_id: 3)

 u3.save!
 u4.save!

p1.save!


