require 'spec_helper'

describe "Registration pages" do

  subject { page }

  let (:signup) { "Sign up" }
  let (:signin) { "Sign in" }
  let (:signout) { "Sign out" }
  let (:edit) { "Edit profile" }

  describe "signup page" do
    before do
      visit new_user_registration_path
    end

    it { should have_content('Sign up') }
  end

  describe "signup" do
    before { visit new_user_registration_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button signup }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      #let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Full name", with: "Test User"
        fill_in "Email", with: "testuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        fill_in "Phone", with: "+041234567"
        fill_in "Birthday", with: "04/11/1990"
      end

      it "should create a user" do
        expect { click_button signup }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button signup }
        let(:user) { User.find_by(email: 'testuser@example.com') }

        it { should have_link(signout) }
        it { should have_link(edit) }
        it { should have_content(user.full_name) }
      end
    end
  end

end
