# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Category.create(name: "Technology", sort_order: 1)
Category.create(name: "Children", sort_order: 2)
Category.create(name: "Travel", sort_order: 3)
Category.create(name: "Romance", sort_order: 4)