FactoryGirl.define do
  factory :message do
    text     Faker::Lorem.sentence
    image    Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/factories/2018-01-08 1.22.55.png'))
    user
    group
  end
end
