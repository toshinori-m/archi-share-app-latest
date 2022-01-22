class Architecture < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :nullify
  validates :image, presence: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :prefecture, presence: true
  validates :address, presence: true, length: { maximum: 50 }
  validates :lat, presence: true
  validates :lng, presence: true
end
