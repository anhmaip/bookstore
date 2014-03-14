Before do
  @user ||= FactoryGirl.build(:user)
end

def find_user
  User.find_by_email(@user.email)
end

def sign_up
  visit new_user_registration_path
  fill_in "Full name", with: @user.full_name
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: @user.password_confirmation
  fill_in "Phone", with: @user.phone
  fill_in "Birthday", with: @user.birthday
  click_button @signup
end

def delete_user
  tmpUser = User.find_by_email(@user.email)
  tmpUser.destroy unless tmpUser.nil?
end