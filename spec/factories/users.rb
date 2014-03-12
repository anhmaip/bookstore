FactoryGirl.define do
  factory :user do
    full_name "Test user"
    email "testuser@example.com"
    password "password"
    password_confirmation "password"
    phone "+0412345678"
    birthday "07/11/1988"
    confirmed_at Time.now
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm! }
  end
end