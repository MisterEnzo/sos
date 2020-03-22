require 'rails_helper'

feature 'Signing up' do
  scenario 'successfully sign up a new user' do
    visit('/')
    click_on('Sign-up')
    expect(page).to have_current_path(new_user_registration_path)
    fill_in 'user_name', with: 'sample'
    fill_in 'user_email', with: 'sample@sos.com'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    click_button('Sign up')
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(User.last.name).to eq('sample')
    expect(page).to have_content('Contact')
    expect(page).to have_content('Name')
    expect(page).to have_content('Email')
    expect(page).to have_button('Add Contact')
  end

  scenario 'unsuccessfully signing-up a user' do
    visit('/')
    click_on('Sign-up')
    expect(page).to have_current_path(new_user_registration_path)
    fill_in 'user_name', with: 'sample'
    click_on('Sign up')
    expect(page).to have_content('2 errors')
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end