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
  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

When(/^I sign in with invalid password$/) do
  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: "Wrong password"
  click_button "Sign in"
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

When(/^I enter new email$/) do
  fill_in "Email", with: "newemail@example.com"
end

When(/^I click on "(.*?)" button$/)  do |button|
  click_button button
end

When(/^I enter the current password$/) do
  fill_in "Current password", with: @user.password
end

When(/^I enter new password$/) do
  fill_in "Password", with: "newpassword"
end

When(/^I enter new password confirmation$/) do
  fill_in "Password confirmation", with: "newpassword"
end

When(/^I enter new non\-password\-required user information$/) do
  fill_in "Full name", with: "New name"
  fill_in "Phone", with: "9876543"
  fill_in "Birthday", with: Date.today
end

Then(/^I should receive a confirmation email$/) do
  ActionMailer::Base.deliveries.last.to.should include @user.email
end

Then(/^I should receive a confirmation email sent to new email$/) do
  ActionMailer::Base.deliveries.last.to.should include "newemail@example.com"
end