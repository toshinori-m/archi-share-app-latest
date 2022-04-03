FactoryBot.define do
  factory :post do
    title { 'a' * 15 }
    content { 'a' * 100 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }

    association :user
  end
end
