require 'rails_helper'
require_relative '../support/login_form'

feature "Signing-in" do
  let(:user) { FactoryBot.create(:user) }
  let(:login_form) { LoginForm.new }
  let(:contacts) { FactoryBot.create_list(:contact, 5, user: user) } 

  scenario "successful login redirects to sos" do
    login_form.visit_page.login_as(user)
    expect(page).to have_content("SOS")
  end
end