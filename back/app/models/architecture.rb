class Architecture < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :nullify
  validates :image, presence: true
  validates :name, presence: true, uniqueness: true
  validates :prefecture, presence: true
  validates :address, presence: true
end
