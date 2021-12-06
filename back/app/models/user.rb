# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  has_many :posts, -> { order('created_at DESC') }, dependent: :destroy, inverse_of: :user
  has_many :post_likes, -> { order('created_at DESC') }, dependent: :destroy, inverse_of: :user
  has_many :postlike, through: :post_likes, source: :post
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  def unlike(other_post)
    like = self.post_likes.find_by(post_id: other_post.id)
    like&.destroy if like
  end

  def follow(other_user)
    self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
