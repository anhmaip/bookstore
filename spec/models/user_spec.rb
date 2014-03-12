require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should respond_to(:full_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:birthday) }
  it { should respond_to(:phone) }
  it { should respond_to(:created_at) }

  it { should be_valid }

  # validate name

  describe "when name is not present" do
    before { user.full_name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { user.full_name = "a" * ( User::FULL_NAME_MAX_LENGTH + 1 ) }
    it { should_not be_valid }
  end

  # validate email

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user
                     user1234@
                     user@foo,com
                     user_at_foo.org
                     example.user@foo.]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user1234@foo.bar
                     user@foo.COM
                     A_US-ER@f.b.org
                     frst.lst@foo.jp
                     a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = user.dup
      user_with_same_email.email = user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }

  end

  #validate password

  describe "when password is not present" do
    before { user.password = "" }
    it { should_not be_valid }
  end

  describe "when password confirmation is not present" do
    before { user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { user.password = user.password_confirmation = "a" * (User::PASSWORD_MIN_LENGTH - 1) }
    it { should_not be_valid }
  end

  # validate birthday

  describe "when birthday is later than today" do
    before { user.birthday = Date.today + 1 }
    it { should_not be_valid }
  end

  # validate phone

  describe "when phone format is invalid" do
    it "should be invalid" do
      phones = ["-", "+",
                "a1234b1234",
                "+1 abc 235",
                "(84) 1234 3456"] # Currently does not support this
      phones.each do |invalid_phone|
        user.phone = invalid_phone
        expect(user).not_to be_valid
      end
    end
  end

  describe "when phone format is valid" do
    it "should be valid" do
      phones = ["",
                "+04 574 0350",
                "38 27 27 27",
                "0989-097-680",
                "+ 84 4 1234566",
                "12345678"]
      phones.each do |valid_phone|
        user.phone = valid_phone
        expect(user).to be_valid
      end
    end
  end
 end
