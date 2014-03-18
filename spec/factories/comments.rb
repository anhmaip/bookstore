FactoryGirl.define do
  factory :comment do
    rating 3
    content Faker::Lorem.paragraph
    book
    user
  end
end