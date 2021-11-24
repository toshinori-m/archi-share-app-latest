FactoryBot.define do
  factory :relationship do
    user_id { create(:user).id }
    follow_id { create(:user).id }
  end
end
