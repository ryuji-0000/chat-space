FactoryGirl.define do
  factory :user do
    password = Faker::Internet.password(8)
    name                  Faker::Name.unique.name
    email                 Faker::Internet.unique.free_email
    password              password
    password_confirmation password
  end
end
