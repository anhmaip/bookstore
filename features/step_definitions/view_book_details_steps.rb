Given(/^System has some books$/) do
  @book = FactoryGirl.create(:book_with_comments)
end

When(/^I visit the link of a book$/) do
  visit book_path(@book)
end

Then(/^I should see all details of the book$/) do
  page.should have_content(@book.title)
  page.should have_content(@book.description)
  page.should have_content(@book.author_name)
  page.should have_content(@book.publisher_name)
  page.should have_content(@book.published_date)
  page.should have_content(@book.unit_price)
  page.should have_content(@book.total_rating_count)
  page.should have_content(@book.average_rating)
end

And(/^I should see the comment list of the book$/) do
  comments = @book.comments
  comments.each do |comment|
    page.should have_content(comment.content)
    page.should have_content(comment.rating)
    page.should have_content(comment.user.full_name)
    page.should have_content(comment.created_at)
  end
end