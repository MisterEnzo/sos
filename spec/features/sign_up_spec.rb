require 'rails_helper'

feature 'Signing up' do
  scenario 'successfully sign up a new user' do
    visit('/')
    click_on('Sign-up')
    expect(page).to have_current_path(new_user_registration_path)
    
  end
end