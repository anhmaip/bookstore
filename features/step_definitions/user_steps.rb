Given(/^I have signed up for a new account$/) do
  delete_user
  sign_up
end

Given(/^I have not signed up for an account$/) do
  delete_user
end

Then(/^My account should be activated$/) do
  find_user.confirmed_at.should_not be_nil
end

When(/^I click on the confirmation link in the confirmation email$/) do
  token = ActionMailer::Base.deliveries.last.body.match(/confirmation_token=\w*/)
  visit "/users/confirmation?#{token}"
end

Then(/^I should be redirected to the Sign in page$/) do
  page.should have_content "Sign in"
end

Then(/^I should be signed in$/) do
  page.should have_content "Sign out"
  page.should have_content "Edit profile"
  page.should_not have_content "Sign in"
end

Then(/^I should not be signed in$/) do
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
  page.should_not have_content "Edit profile"
end

When(/^I sign in with valid email and password$/) do
  sign_in(@user.email, @user.password)
end

When(/^I sign in with invalid password$/) do
  sign_in(@user.email, "Wrongpassword")
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content message
end

Given(/^I have an activated account$/) do
  @user.save
  @user.confirm!
end

Given(/^I visit Edit Profile link$/) do
  visit edit_user_registration_path
end

When(/^I click on "(.*?)" button$/)  do |button|
  click_button button
end

Then(/^I should receive a confirmation email sent to "(.*?)"$/) do |email|
  ActionMailer::Base.deliveries.last.to.should include email
end

When(/^I enter "(.*?)" field with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end