module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.includes(
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ).find(params[:id])

        render json: @user, serializer: UserProfileSerializer, include: [
          { posts: %i[like_users comments] },
          { postlike: %i[user like_users comments] },
          :followings,
          :followers
        ]
      end

      def destroy
        @user = User.find(params[:id])
        render json: @user if @user.destroy
      end
    end
  end
end
