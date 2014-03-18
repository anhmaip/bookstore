Then(/^I should not see "(.*?)" box$/) do |tool|
  page.should_not have_selector(".#{tool}-box")
end

Then(/^I should see "(.*?)" box$/) do |tool|
  page.should have_selector(".#{tool}-box")
end

Given(/^I have commented on that book before$/) do
  comment_rate("My first comment", 3)
end

Given(/^I have rated that book before$/) do
  comment_rate("My first comment", 3)
end

When(/^I comment "(.*?)" and rate (\d+)$/) do |comment, rate|
  comment_rate(comment, rate.to_i)
end