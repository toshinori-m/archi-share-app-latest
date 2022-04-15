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
        if @user.unfollow(@follow)
          render json: @user, serializer: UserProfileSerializer, include: [
            { posts: %i[like_users comments] },
            { postlike: %i[user like_users comments] },
            :followings,
            :followers
          ]
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.includes(
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ).find(params[:user_id])

        @follow = User.includes(
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ).find(params[:follow_id])
      end
    end
  end
end
