module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      attributes :id,
                 :title,
                 :content,
                 :image,
                 :created_at

      belongs_to :user
    end
  end
end
