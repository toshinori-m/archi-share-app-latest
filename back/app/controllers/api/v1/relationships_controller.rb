module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        @user.follow(@follow)
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
        if @user.unfollow(@follow)
          render json: @user.as_json(
            only: %i[id name email introduction image admin],
            include: [
              { posts: { include: [:like_users], only: %i[id title content image created_at] } },
              { postlike: { include: [{ user: { only: %i[id name image] } }, :like_users] } },
              :followings,
              :followers
            ]
          )
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @follow = User.find(params[:follow_id])
      end
    end
  end
end
