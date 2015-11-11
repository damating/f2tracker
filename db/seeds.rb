# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Badges
brown = Badge.create(name: 'brown', points_limit: 5, icon: 'brown2.png')
silver = Badge.create(name: 'silver', points_limit: 10, icon: 'silver2.png')
gold = Badge.create(name: 'brown', points_limit: 15, icon: 'gold2.png')


#Admin
arthur = Player.create(first_name: 'Arthur', last_name: 'Arthur', email: 'arthur@email.com', password: 'Admin123', password_confirmation: 'Admin123', role: 'admin', avatar: File.open('app/assets/images/avatar_ma.png'))

#Players
bob = Player.create(first_name: 'Bob', last_name: 'Bob', email: 'bob@email.com', password: 'Bob123', password_confirmation: 'Bob123', role: 'player', avatar: File.open('app/assets/images/avatar_m1.png'))
alex = Player.create(first_name: 'Alex', last_name: 'Alex', email: 'alex@email.com', password: 'Alex123', password_confirmation: 'Alex123', role: 'player', avatar: File.open('app/assets/images/avatar_m5.png'))
anna = Player.create(first_name: 'Anna', last_name: 'Anna', email: 'anna@email.com', password: 'Anna123', password_confirmation: 'Anna123', role: 'player', avatar: File.open('app/assets/images/avatar_w3.png'))
john = Player.create(first_name: 'John', last_name: 'John', email: 'john@email.com', password: 'John123', password_confirmation: 'John123', role: 'player', avatar: File.open('app/assets/images/avatar_m2.png'))
andrew = Player.create(first_name: 'Andrew', last_name: 'Andrew', email: 'andrew@email.com', password: 'Andrew123', password_confirmation: 'Andrew123', role: 'player', avatar: File.open('app/assets/images/avatar_m3.png'))
celine = Player.create(first_name: 'Celine', last_name: 'Celine', email: 'celine@email.com', password: 'Celine123', password_confirmation: 'Celine123', role: 'player', avatar: File.open('app/assets/images/avatar_w2.png'))
julia  = Player.create(first_name: 'Julia', last_name: 'Julia', email: 'julia@email.com', password: 'Julia123', password_confirmation: 'Julia123', role: 'player')
lily  = Player.create(first_name: 'Lily', last_name: 'Lily', email: 'lily@email.com', password: 'Lily123', password_confirmation: 'Lily123', role: 'player')
paul  = Player.create(first_name: 'Paul', last_name: 'Paul', email: 'paul@email.com', password: 'Paul123', password_confirmation: 'Paul123', role: 'player')
luke  = Player.create(first_name: 'Luke', last_name: 'Luke', email: 'luke@email.com', password: 'Luke123', password_confirmation: 'Luke123', role: 'player')


