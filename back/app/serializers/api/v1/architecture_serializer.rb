module Api
  module V1
    class ArchitectureSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :prefecture,
                 :address,
                 :lat,
                 :lng,
                 :construction,
                 :designer,
                 :above_floor,
                 :under_floor,
                 :image

      has_many :posts
    end
  end
end
