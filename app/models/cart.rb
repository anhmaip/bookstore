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

  def update_cart
  end

  def expired?
    self.session[:cart][:created_at] < 3.hours.ago
  end

  private
    def set_book(book_id)
      @requested_book = Book.find_by_id(book_id) unless book_id.nil?
    end
end