require 'rails_helper'

feature 'home page' do
  scenario 'visit home page' do
    visit('/')
    expect(page).to have_content("SOS")
    expect(page).to have_button("Login")
    expect(page).to have_button("Sign-Up")
  end
end

