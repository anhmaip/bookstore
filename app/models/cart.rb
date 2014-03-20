class Cart
  attr_accessor :session
  attr_reader :requested_book, :books

  def initialize(session)
    self.session = session
    self.session[:cart] ||= {
        books: Hash.new, # Hash{book_id{price, quantity}}
        total_amount: 0,
        created_at: Time.now
    }
    @books = self.session[:cart][:books]
  end

  def add_book(book_id)
    set_book(book_id)
    unless self.requested_book.nil?
      if @books[book_id].nil?
        @books[book_id] = Hash.new
        @books[book_id][:quantity] = 1
      else
        @books[book_id][:quantity] = @books[book_id][:quantity].to_i + 1
      end
      @books[book_id][:total_price] = @books[book_id][:quantity] * self.requested_book.unit_price
      self.session[:cart][:total_amount] += self.requested_book.unit_price
      return true
    else
      return false
    end
  end

  def remove_book(book_id)
  end

  def update_cart(book_ids, quantities)
    book_ids.each_with_index do |book_id, index|
      update_item(book_id, quantities[index])
    end
  end

  def expired?
    self.session[:cart][:created_at] < 3.hours.ago
  end

  private
    def set_book(book_id)
      @requested_book = Book.find_by_id(book_id) unless book_id.nil?
    end

    def update_item(book_id, quantity)
      if !book_id.nil? && !quantity.nil? && quantity.to_i > 0
        book = Book.find_by_id(book_id) unless book_id.nil?
        unless book.nil?
          quantity_diff = quantity.to_i - @books[book_id][:quantity].to_i
          @books[book_id][:quantity] = quantity
          @books[book_id][:total_price] = quantity.to_i * book.unit_price
          self.session[:cart][:total_amount] += quantity_diff * book.unit_price
        end
      end
    end
end