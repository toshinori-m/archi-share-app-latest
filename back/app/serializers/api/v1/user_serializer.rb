module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :image,
                 :email,
                 :introduction,
                 :admin

      has_many :posts
      has_many :comments
    end
  end
end
