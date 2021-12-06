module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all.order(id: 'DESC')
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
          only: %i[id name email introduction image],
          include: [
            {
              posts: {
                include: [:like_users],
                only: %i[id title content image]
              }
            },
            {
              postlike: {
                include: [
                  { user: { only: %i[id name image] } },
                  :like_users
                ]
              }
            },
            :followings,
            :followers
          ]
        )
      end
    end
  end
end
