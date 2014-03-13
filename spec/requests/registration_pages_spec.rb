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

    it { should have_content(signup) }
  end

  describe "signup" do
    before { visit new_user_registration_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button signup }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }

      before do
        fill_in "Full name", with: user.full_name
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password_confirmation
        fill_in "Phone", with: user.phone
        fill_in "Birthday", with: user.birthday
      end

      it "should create a user" do
        expect { click_button signup }.to change(User, :count).by(1)
      end

      describe "should show confirmation message to user after saving the user" do
        before do
          ActionMailer::Base.deliveries.clear
          click_button signup
        end

        it { should have_content('confirmation link has been sent to your email address') }

        it 'should send an email to user' do
          ActionMailer::Base.deliveries.count.should == 1
          ActionMailer::Base.deliveries.last.to.should include(user.email)
        end
      end
    end
  end
end
