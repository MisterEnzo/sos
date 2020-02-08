class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts
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

  private 
  
    def contact_params
      params.require(:contact).permit(:name, :email)
    end
end
