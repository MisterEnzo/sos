class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  def show
  end

  def index
    if current_user
      @contacts = current_user.contacts
    else
      redirect_to user_session
  end

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      redirect_to contacts_path current_user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact.id)
    else
      render 'edit'
    end
  end

  private 
    def contact_params
      params.require(:contact).permit(:name, :email)
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end
end
