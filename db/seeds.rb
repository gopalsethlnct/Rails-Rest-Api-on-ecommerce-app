# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# admin_role = Role.create(name: 'seller')
# # client_role = Role.create(name: 'client')
# user1 = User.create(username: 'Nicole',
# 								    email: 'admin@gmail.com',
# 								    password: 'password1234',
# 								    password_confirmation: 'password1234',
#                                     phone: 1233,
#                                 role_id:1)

# user2 = User.create(username: 'Bruce',
# 								    email: 'client@gmail.com',
# 								    password: 'password1234',
# 								    password_confirmation: 'password1234',
#                                     phone: 1233)

user1 = User.create(username: 'gopal',
								    email: 'gopal@gmail.com',
								    password: 'password1234',
								    password_confirmation: 'password1234',
                                    phone: 1233,
                                    role_id:5)
seller = Seller.create(user_id: user1.id, name: 'seller1')

Inventory.create(product_id: 1, quantity: 20, seller_id: seller.id)
