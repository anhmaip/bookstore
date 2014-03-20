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

        it "should not change the number of book item in cart" do
          expect(cart.session[:cart][:books].count).to eq 1
        end

        it "should update quantity of that book" do
          expect(cart.session[:cart][:books][book.id][:quantity]).to eq 2
        end

        it "should update total price of that book" do
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

  describe "update cart" do
    before { cart.add_book(book.id) }

    describe "when new quantity is positive" do
      let(:new_quantity) { 2 }

      before do
        cart.update_cart([book.id], [new_quantity])
      end

      it "should update quantity of book item" do
        expect(cart.session[:cart][:books][book.id][:quantity]).to eq new_quantity
      end

      it "should update total price of book item" do
        expect(cart.session[:cart][:books][book.id][:total_price]).to eq (book.unit_price * new_quantity)
      end

      it "should update total amount" do
        expect(cart.session[:cart][:total_amount]).to eq (book.unit_price * new_quantity)
      end
    end

    describe "when new quantity is invalid" do
      quantities = [0, "-1", ""]

      quantities.each do |quantity|
        before do
          cart.update_cart([book.id], [quantity])
        end

        it "should not update cart" do
          expect(cart.session[:cart][:books].count).to eq 1
          expect(cart.session[:cart][:books][book.id][:quantity]).to eq 1
          expect(cart.session[:cart][:books][book.id][:total_price]).to eq book.unit_price
        end
      end
    end
  end
end