FactoryBot.define do
  factory :post do
    association :user
    title { 'a' * 15 }
    content { 'a' * 100 }
  end
end
