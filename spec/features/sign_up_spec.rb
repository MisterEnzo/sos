require 'rails_helper'

feature 'sign up' do
  scenario 'create a new user from home page' do
    visit('/')
    click_link('Sign-Up')
    expect(page).to have_current_path(new_user_registration_path)
  end
end