FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content { 'a' * 50 }
  end
end
