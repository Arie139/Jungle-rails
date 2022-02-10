require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do
      @user = User.new(first_name: "First",last_name: "Last", email: "test@email.com", password: "123456", password_confirmation: "123456")
    end

    it 'creates a user when password and confirmation match' do
      expect(@user).to be_valid
    end
    
    it 'error when password and confirmation do not match' do
      @user.password = "456789"
      expect(@user).not_to be_valid
    end
    
    it 'error when password is not given' do
      @user.password = nil
      expect(@user).not_to be_valid
    end
    
    it 'error when confirmation is not given' do
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
    end
    
    it 'error when email is not given' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'error when first name is not given' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'error when last name is not given' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'error when email is not case sensitive)' do
      @user.save
      @new_user = User.new(first_name: "yo", last_name: "me", email: "test@EMAIL.com", password: "456789", password_confirmation: "456789")
      expect(@user).to be_valid
      expect(@new_user).not_to be_valid
    end
  end 
  
  describe '.authenticate_with_credentials' do
    before do
      @user = User.new(first_name: "First",last_name: "Last", email: "test@email.com", password: "123456", password_confirmation: "123456")
      @user.save
    end

    it 'User login' do
      @login_user = User.authenticate_with_credentials('test@email.com', '123456')
      expect(@user).to eq(@login_user)
    end
    
    it 'does not login email is incorrect' do
      @login_user = User.authenticate_with_credentials('email.com', '123456')
      expect(@user).not_to eq(@login_user)
    end
    
    it 'does not login when password is incorrect' do
      @login_user = User.authenticate_with_credentials('test@email.com', '222222')
      expect(@user).not_to eq(@login_user)
    end
    
    it 'login when email has whitespace' do
      @login_user = User.authenticate_with_credentials('  test@email.com ', '123456')
      expect(@user).to eq(@login_user)
    end
  end
end