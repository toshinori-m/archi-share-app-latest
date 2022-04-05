module Api
  module V1
    class CommentSerializer < ActiveModel::Serializer
      attributes :id,
                 :content

      belongs_to :user
      belongs_to :post
    end
  end
end
