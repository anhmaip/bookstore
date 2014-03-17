#Given(/^Categories have been pre\-populated$/) do
#  @category ||= FactoryGirl.create(:category)
#end
#
#When(/^I visit the Home page$/) do
#  visit root_path
#end
#
#Then(/^I should see all categories listed$/) do
#  page.should have_content(@category.name)
#end

Given(/^System has (\d+) categories, each has (\d+) books$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I visit the Home page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the links to all categories listed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I visit "(.*?)" category link$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see book (\d+) to (\d+) of the category$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see page "(.*?)" for the other books$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I click on page "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end