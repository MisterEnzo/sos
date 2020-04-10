require 'rails_helper'

RSpec.describe Users::SossController do
  describe "GET new" do
    let(:user) { FactoryBot.create(:user) }
    let(:contact) { FactoryBot.create(:contact, user: user) }
    it "renders :new template when user visits sos page" do
      sign_in(user)
      expect(user).to eq(User.first)
      expect(contact).to eq(Contact.first)
      expect(User.count).to eq(1)
      expect(Contact.count).to eq(1)
      get :new
      expect(response).to render_template(:new)
    end
  end
end