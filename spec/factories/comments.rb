FactoryGirl.define do
  factory :comment do
    rating 3
    content Faker::Lorem.paragraph
    user
  end
end