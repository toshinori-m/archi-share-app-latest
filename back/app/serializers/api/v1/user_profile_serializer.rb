module Api
  module V1
    class UserProfileSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :image,
                 :email,
                 :introduction,
                 :admin

      has_many :posts
      has_many :postlike
      has_many :followings
      has_many :followers
    end
  end
end
