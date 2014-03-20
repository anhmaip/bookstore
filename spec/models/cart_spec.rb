require 'spec_helper'

describe Cart do
  let(:book) { FactoryGirl.create(:book) }
  let(:cart) { Cart.new(Hash.new) }

  describe "init cart" do
    it "should initialize a cart in session" do
      expect(cart.session[:cart]).not_to be_nil
      expect(cart.session[:cart][:books]).to be_empty
      expect(cart.session[:cart][:total_amount]).to eq 0
    end
  end

  describe "check if expired" do
    describe "when book is created less than 3 hours ago" do
      before { cart.session[:cart][:created_at] = 2.hours.ago }
      it "should not be expired" do
        cart.should_not be_expired
      end
    end

    describe "when book is created more than 3 hours ago" do
      before { cart.session[:cart][:created_at] = 4.hours.ago }
      it "should not be expired" do
        cart.should be_expired
      end
    end
  end

  describe "add book" do
    describe "when book can be found in database" do
      before { cart.add_book(book.id) }

      it "should add a book to session cart" do
        expect(cart.session[:cart][:books].count).to eq 1
        expect(cart.session[:cart][:books][book.id][:quantity]).to eq 1
        expect(cart.session[:cart][:books][book.id][:total_price]).to eq book.unit_price
      end

      it "should update total amount" do
        expect(cart.session[:cart][:total_amount]).to eq book.unit_price
      end

      describe "when book is added again to cart" do
        before { cart.add_book(book.id) }

        it "should increase the amount of that book in session cart" do
          expect(cart.session[:cart][:books].count).to eq 1
          expect(cart.session[:cart][:books][book.id][:quantity]).to eq 2
          expect(cart.session[:cart][:books][book.id][:total_price]).to eq (book.unit_price * 2)
        end

        it "should update total amount" do
          expect(cart.session[:cart][:total_amount]).to eq (book.unit_price * 2)
        end
      end
    end

    describe "when book cannot be found in database" do
      it "should not add a book to session cart" do
        expect { cart.add_book("0") }.to change(cart.session[:cart][:books], :count).by(0)
      end
    end
  end
end