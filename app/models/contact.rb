class Contact < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: {
    scope: :user_id,
    message: can't be the same as another contact's email
  }

end
