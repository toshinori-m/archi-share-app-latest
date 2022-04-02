module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.includes(
          :posts,
          { postlike: :like_users },
          :followings,
          :followers
        ).find(params[:id])
        render json: @user.as_json(
          include: [
            { posts: { include: %i[like_users comments], only: %i[id title content image created_at] } },
            { postlike: { include: [{ user: { only: %i[id name image] } }, :like_users, :comments] } },
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
