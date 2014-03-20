class Cart
  attr_reader :session

  def initialize(session)
    @session = session
    @session[:cart] ||= {
        books: Hash.new, # Hash{book_id{price, quantity}}
        total_amount: 0,
        created_at: Time.now
    }
    @books = @session[:cart][:books]
  end

  def add_book(book_id)
    @requested_book = Book.find_by_id(book_id) if book_id.present?
    if @requested_book.present?
      if @books[book_id].nil?
        @books[book_id] = Hash.new
        @books[book_id][:quantity] = 1
      else
        @books[book_id][:quantity] += 1
      end
      @books[book_id][:total_price] = @books[book_id][:quantity] * @requested_book.unit_price
      @session[:cart][:total_amount] += @requested_book.unit_price
      return true
    else
      return false
    end
  end

  def remove_book(book_id)
    @requested_book = Book.find_by_id(book_id) if book_id.present?
    if @requested_book.present? && @books[book_id].present?
      @session[:cart][:total_amount] -= @books[book_id][:quantity] * @requested_book.unit_price
      @books.delete(book_id)
    end
  end

  def update_cart(book_ids, quantities)
    book_ids.each_with_index do |book_id, index|
      update_item(book_id, quantities[index])
    end
  end

  def expired?
    @session[:cart][:created_at] < 3.hours.ago
  end

  private
    def update_item(book_id, quantity)
      if !book_id.nil? && !quantity.nil? && quantity.to_i > 0
        book = Book.find_by_id(book_id) if book_id.present?
        if book.present?
          quantity = quantity.to_i
          quantity_diff = quantity - @books[book_id][:quantity]
          @books[book_id][:quantity] = quantity
          @books[book_id][:total_price] = quantity * book.unit_price
          @session[:cart][:total_amount] += quantity_diff * book.unit_price
        end
      end
    end
end