def comment_rate(content, rating)
  visit book_path(@book)
  fill_in "comment_content", with: content
  select rating.to_i, from: "comment_rating"
  click_button "Post"
end