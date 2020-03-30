require 'rails_helper'

RSpec.describe ContactsController do
  describe "GET new" do
    let(:user) { FactoryBot.create(:user) }
    it "renders :new template when user is logged in" do
      expect(user).to eq(User.first)
      sign_in(user)
      get :new
      expect(response).to have_http_status(:success)
      # expect(response).to redirect_to(new_user_session_path)
      expect(response).to render_template(:new)
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it "redirects to login page if not logged in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET show" do
    let(:user) { FactoryBot.create(:user) }
    let(:contact) { FactoryBot.create(:contact, user: user) }
    it "redirects to sign_in page if a user isn't logged-in" do
      expect(user).to eq(User.first)
      expect(contact).to eq(Contact.first)
      get :show, params: { id: contact.id }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "renders :show template after user has logged in" do 
      sign_in(user)
      get :show, params: { id: contact.id }
      expect(response).to render_template(:show)
    end
  end
end

