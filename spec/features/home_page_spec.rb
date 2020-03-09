require 'rails_helper'

RSpec.describe 'home page' do
  it 'has the SOS logo, and login and signup buttons' do
    visit('/')
    expect(page).to have_content("SOS")
    expect(page).to have_link("Login")
    expect(page).to have_link("Sign-up")
  end
end

