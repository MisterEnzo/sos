require 'rails_helper'

RSpec.describe ContactsController do
  describe "GET new" do
    let(:user) { FactoryBot.create(:user) }

    it "renders :new template when user is logged in" do
      expect(user).to eq(User.first)
      sign_in(user)
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it "redirects to login page if not logged in" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  describe "POST create" do
    context "User successfully logs-in and creates a new contact" do
    let(:user) { FactoryBot.create(:user) }
      it "redirects to contacts#index after successful creation of new contact" do
        sign_in(user)
        post :create, params: { contact: FactoryBot.attributes_for(:contact) }
        expect(response).to redirect_to(contacts_path)
      end

      it "creates new contact in the database" do
        sign_in(user)
        expect {
          post :create, params: { contact: FactoryBot.attributes_for(:contact) }
        }.to change(Contact, :count).by(1)
      end
    end
  end

  describe "GET edit" do
    let(:user) { FactoryBot.create(:user) }
    let(:contact) { FactoryBot.create(:contact, user: user)}
    
    context "User doesn't sign-in" do
      it "redirects user to sign-up when trying to edit" do
        get :edit, params: { id: contact }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context "User successfully signs-in" do
      it "User is redirected to contacts#index if the contact to be edited doesn't exist" do
        sign_in(:user)
        get :edit, params: { id: 100 }
        expect(response).to redirect_to(contacts_path)
      end
    end
  end
end

