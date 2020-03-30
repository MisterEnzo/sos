FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Contact_#{n}" }
    sequence(:email) { |n| "contact_#{n}@example.com"}
  end
end
