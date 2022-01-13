module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users.as_json(
          only: %i[id name email introduction image]
        )
      end

      def show
        @user = User.includes(
          :posts,
          { postlike: :like_users },
          :followings,
          :followers
        ).find(params[:id])
        render json: @user.as_json(
          only: %i[id name email introduction image admin],
          include: [
            { posts: { include: [:like_users], only: %i[id title content image created_at] } },
            { postlike: { include: [{ user: { only: %i[id name image] } }, :like_users] } },
            :followings,
            :followers
          ]
        )
      end

      def destroy
        @user = User.find(params[:id])
        render json: @user if @user.destroy
      end
    end
  end
end
