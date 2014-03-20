require 'spec_helper'

describe CartsController do
  let(:book) { FactoryGirl.create(:book) }

  describe "add book" do
    describe "when user is not signed in and cart is just created" do
      before { post :add_book, book_id: book.id }

      it "shows a succesful message" do
        flash[:success].should == "Book added succesfully to cart"
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is signed in and cart is created more than 3 hours ago" do
      let(:user) { FactoryGirl.create(:confirmed_user) }

      before do
        sign_in user
        Cart.new(session)
        session[:cart][:create_at] = 4.hours.ago
        post :add_book, book_id: book.id
      end

      it "shows a succesful message" do
        flash[:success].should == "Book added succesfully to cart"
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is not signed in and cart is created more than 3 hours ago" do
      before do
        Cart.new(session)
        session[:cart][:created_at] = 4.hours.ago
        post :add_book, book_id: book.id
      end

      it "resets cart to empty" do
        session[:cart][:books].should be_empty
      end

      it "shows an alert message" do
        flash[:alert].should == "Your shopping cart has expired!"
      end

      it "redirects to the root path" do
        response.should redirect_to root_path
      end
    end
  end
end