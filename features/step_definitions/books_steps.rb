Given(/^Categories have been pre\-populated$/) do
  @category ||= FactoryGirl.create(:category)
end

When(/^I visit the Home page$/) do
  visit root_path
end

Then(/^I should see all categories listed$/) do
  page.should have_content(@category.name)
end