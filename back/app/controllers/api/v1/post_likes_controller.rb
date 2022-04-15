module Api
  module V1
    class PostLikesController < ApplicationController
      before_action :set_post

      def create
        @postlike = PostLike.new(like_params)
        if @postlike.save
          render json: @post, include: [
            :user,
            :architecture,
            :like_users,
            { comments: :user }
          ], status: :created
        else
          render json: @postlike.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:user_id])
        return unless @user.unlike(@post)

        render json: @post, include: [
          :user,
          :architecture,
          :like_users,
          { comments: :user }
        ]
      end

      private

      def like_params
        params.permit(:user_id, :post_id)
      end

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
