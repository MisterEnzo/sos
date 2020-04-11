class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if current_user
      @contacts = current_user.contacts
    else
      redirect_to user_session
    end
  end

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      flash[:notice] = "You have successfully added a contact"
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def edit
    if @contact.user != current_user
      flash[:alert] = "You are not permitted to edit other user's contacts."
      redirect_to contacts_path
    end
  end

  def update
    if @contact.update(contact_params)
      flash[:notice] = "You have successfully modified your contact."
      redirect_to contacts_path
    else
      render 'edit'
    end
  end

  def destroy
    if @contact.user == current_user
      @contact.destroy
      flash[:notice] = "You have successfully deleted your contact."
      redirect_to contacts_url
    else
      redirect_to contacts_url
    end
  end

  private 
    def contact_params
      params.require(:contact).permit(:name, :email)
    end

    def set_contact
      begin
        @contact = Contact.find(params[:id])
      rescue ActiveRecord::RecordNotFound 
        redirect_to contacts_url
        return
      end
    end
end
