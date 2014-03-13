@signup = "Sign up"
@signin = "Sign in"

def build_user
  @user ||= FactoryGirl.build(:user)
end

def sign_up
  visit new_user_registration_path
  fill_in "Full name", with: @user.full_name
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: @user.password_confirmation
  fill_in "Phone", with: @user.phone
  fill_in "Birthday", with: @user.birthday
  click_button @signup
end

Given(/^I have signed up for a new account$/) do
  build_user
  sign_up
end

When(/^I click on the confirmation link in the confirmation email$/) do
  token = ActionMailer::Base.deliveries.last.body.match(/confirmation_token=\w*/)
  visit "/users/confirmation?#{token}"
end

Then(/^I should be redirected to the Sign in page$/) do
  page.should have_link(@signin)
end

Then(/^I should see a successfully confirmed message$/) do
  page.should have_content("Your account was successfully confirmed")
end

Then(/^My User database record is updated with confirmed time$/) do
  @user.confirmed_at.should_not be_nil
end