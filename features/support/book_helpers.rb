def comment_rate(content, rating)
  visit book_path(@book)
  fill_in "comment_content", with: content
  select rating.to_i, from: "comment_rating"
  click_button "Post"
end

def update_books(category, book_count, field, value)
  if category.books.count >= book_count
    i = 0
    while i < book_count do
      category.books[i].update_attribute(field, value)
      category.books[i].index!
      i += 1
    end
  end
end