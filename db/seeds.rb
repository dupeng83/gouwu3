# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.exists?(email: "admin@example.com")
  User.create!(email: "admin@example.com", password: "password", admin: true)
end

unless User.exists?(email: "viewer@example.com")
  User.create!(email: "viewer@example.com", password: "password")
end

unless Product.exists?(name: "电水壶")
  Product.create!(name: "电水壶", price: 100)
end

unless Product.exists?(name: "电视机")
  Product.create!(name: "电视机", price: 1000)
end