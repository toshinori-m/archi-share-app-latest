module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :image,
                 :email,
                 :introduction,
                 :admin
    end
  end
end
