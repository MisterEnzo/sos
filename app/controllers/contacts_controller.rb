class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  def show
  end

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

  def destroy
    if @contact.user == current_user
      @contact.destroy
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
      @contact = Contact.find(params[:id])
    end

    def logged_in?
      redirect_to new_user_session_path if !current_user
    end
end
