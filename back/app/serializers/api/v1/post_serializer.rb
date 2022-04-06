module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      attributes :id,
                 :title,
                 :content,
                 :image,
                 :created_at

      attribute :like_users do
        object.like_users.as_json(only: %i[id name image])
      end

      belongs_to :user
      belongs_to :architecture
      has_many :comments
    end
  end
end
