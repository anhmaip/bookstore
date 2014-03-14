Given(/^I have signed up for a new account$/) do
  delete_user
  sign_up
end

Given(/^I have not signed up for an account$/) do
  delete_user
end

And(/^My account is activated$/) do
  find_user.confirm!
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