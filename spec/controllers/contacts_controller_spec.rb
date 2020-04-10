require 'rails_helper'

RSpec.describe ContactsController do

  describe "GET index" do
    context "user hasn't signed-in" do
      it "redirects user to sign-in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user has signed-in" do
      let(:user) { FactoryBot.create(:user) }
      let(:contacts) { FactoryBot.create_list(:contact, 5, user: user) }
      it "shows all the contacts of the user" do
        sign_in(user)
        get :index
        expect(assigns(:contacts)).to eq(contacts)
      end

      it "renders :index template" do
        sign_in(user)
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

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

      context "enters valid data" do
        it "creates new contact in the database" do
          sign_in(user)
          expect {
            post :create, params: { contact: FactoryBot.attributes_for(:contact) }
          }.to change(Contact, :count).by(1)
          expect(response).to redirect_to(contacts_path) 
        end
      end
      
      context "enters invalid data" do
        let(:invalid_contact) { FactoryBot.attributes_for(:contact, name: '', email: '') }
        it "redirects to contact#new if the data is invalid" do
          sign_in(user)
          expect {
            post :create, params: { contact: invalid_contact }
          }.to change(Contact, :count).by(0)
        end
      end
    end
  end

  describe "GET edit" do
    let(:user) { FactoryBot.create(:user) }
    let(:contact) { FactoryBot.create(:contact, user: user )}
    
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

      it "User is presented with the correct contact to edit" do
        sign_in(:user)
        get :edit, params: { id: contact.id }
        expect(assigns(:contact)).to eq(contact)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PUT update" do
    let(:user) { FactoryBot.create(:user) }
    let(:contact) { FactoryBot.create(:contact, user: user) }
    let(:valid_data) { FactoryBot.attributes_for(:contact, email: "valid@test.com") }
    let(:invalid_data) { FactoryBot.attributes_for(:contact, email: "") }
    context "user signs-in successfully" do
      context "valid data" do
        it "modifies the contact's properties" do
          sign_in(user)
          byebug
          put :update, params: { id: contact.id, contact: valid_data }
          expect(Contact.last.email).to eq("valid@test.com")
          expect(response).to redirect_to(contacts_path)
        end
      end

      context "invalid data" do
        it "redirects to edit page" do  
          sign_in(user)
          put :edit, params: {id: contact.id, contact: invalid_data}
          expect(response).to render_template(:edit)
        end
      end
    end

    context "user doesn't sign in" do
      it "redirects user to sign-in page" do
        put :update, params: {id: contact.id, contact: valid_data }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

