# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


category1 = Category.create(name: "Technology", sort_order: 1)
Category.create(name: "Children", sort_order: 2)
Category.create(name: "Travel", sort_order: 3)
Category.create(name: "Romance", sort_order: 4)
Category.create(name: "Category 7", sort_order: 7)
Category.create(name: "Category 5", sort_order: 5)
Category.create(name: "Category 8", sort_order: 8)
Category.create(name: "Category 6", sort_order: 6)

book1 = Book.create(title: "Ruby on Rails", description: "This is a tutorial for RoB", author_name: "Michael Hart",
                    unit_price: 22.7, publisher_name: "Kim Dong", published_date: "2008/02/22",
                    total_rating_count: 2, total_rating_value: 5)

category1.books << book1

user1 = User.create(full_name: "Commentor1", email: "commentor1@foo.bar",
                    password: "password", password_confirmation: "password", confirmed_at: "2000/10/10")

comment1 = Comment.create(rating: 2, content: "This is a comment for ror book", user: user1, book: book1)

book1.comments << comment1