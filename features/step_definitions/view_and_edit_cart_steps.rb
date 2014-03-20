When(/^I visit the cart link$/) do
  visit carts_path
end

When(/^I change quantity of book (\d+) to (\d+)$/) do |book_index, quantity|
  page.all("input#quantities_")[book_index.to_i - 1].set(quantity)
end