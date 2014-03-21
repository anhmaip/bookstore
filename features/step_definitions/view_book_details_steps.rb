Given(/^System has some books$/) do
  @book = FactoryGirl.create(:book_with_comments)
end

When(/^I visit the link of a book$/) do
  visit book_path(@book)
end

Then(/^I should see all details of the book$/) do
  [:title, :description, :author_name, :publisher_name, :published_date,
   :unit_price, :total_rating_count, :average_rating].each do |attribute|
    page.should have_content(@book.send(attribute))
  end
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