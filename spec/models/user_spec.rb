require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    describe 'creates a new user' do
      it 'validates the successfull creation of a new user' do
        fake_user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: 'john_doe@person.com',
          password: 'qwerty',
          password_confirmation: 'qwerty'
        )

        fake_user.save!
        expect(fake_user.valid?).to be_truthy
      end
    end

    context 'with the same email' do
      it 'validates that the email has been used' do
        existing_user = User.new(
          first_name: 'Doe',
          last_name: 'John',
          email: 'john_doe@person.com',
          password: 'qwerty',
          password_confirmation: 'qwerty'
        )

        validation_user = User.new(
          first_name: 'Doe',
          last_name: 'John',
          email: 'john_doe@person.com',
          password: 'qwerty',
          password_confirmation: 'qwerty'
        )

        puts User.count 
        expect(validation_user.valid?).to be_falsey
      end
    end

  end
end
