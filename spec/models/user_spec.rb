require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a password' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: nil,
                      password_confirmation: 'password')
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires a password confirmation' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'password',
                      password_confirmation: nil)
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'requires matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'different_password'
      )
      expect(user.valid?).to be_falsey
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires email, first name, and last name' do
      user = User.new
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include("can't be blank")
      expect(user.errors[:first_name]).to include("can't be blank")
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'ensures uniqueness of emails (case-insensitive)' do
      existing_user = User.create(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(User.find_by(email: 'test@example.com')).to eq(existing_user)

      user = User.new(
        email: 'TEST@example.com',
        first_name: 'Jane',
        last_name: 'Doe',
        password: 'another_password',
        password_confirmation: 'another_password'
      )
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid) do |error|
        expect(error.record.errors[:email]).to include('has already been taken')
      end
    end

    it 'requires a password with a minimum of 6 characters' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'pass',
                      password_confirmation: 'pass')

      expect(user.valid?).to be_falsey
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    let(:test_email) { 'test@test.com' }
    let(:test_password) { 'qwerty' }

    before do
      # Test user
      @user = User.create(
        email: test_email,
        first_name: 'John',
        last_name: 'Doe',
        password: test_password,
        password_confirmation: test_password
      )
    end

    context 'with valid credentials' do
      it 'returns the user when credentials are correct' do
        authenticated_user = User.authenticate_with_credentials(test_email, test_password)
        expect(authenticated_user).to eq(@user)
      end
    end

  end
end
