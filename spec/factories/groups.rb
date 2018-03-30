FactoryGirl.define do
  factory :group do
    name Faker::Team.unique.creature
  end
end
