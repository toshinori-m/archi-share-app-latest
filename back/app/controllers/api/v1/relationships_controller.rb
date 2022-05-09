module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        @user.follow(@follow)
        render json: @user, serializer: UserProfileSerializer, include: [
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ]
      end

      def destroy
        return head :unprocessable_entity unless @user.unfollow(@follow)

        render json: @user, serializer: UserProfileSerializer, include: [
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ]
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @follow = User.find(params[:follow_id])
      end
    end
  end
end
