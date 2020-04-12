require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validations" do
    it 'requires an email' do
      user = FactoryBot.create(:user)  
      contact = Contact.new(name: "haha", email: "", user: user)
      contact.valid?
      expect(contact.errors).to_not be_empty
    end

    it 'requires a user' do
      contact = Contact.new(name: "test", email: "test@test.com")
      expect(contact.valid?).to be_falsy
    end

    it 'belongs to a user' do
      user = FactoryBot.create(:user)
      contact = FactoryBot.create(:contact, user: user)
      expect(contact.user).to eq(user)
      u = Contact.reflect_on_association(:user)
      expect(u.macro).to eq(:belongs_to)
    end
  end
end
