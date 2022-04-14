module Api
  module V1
    class PostLikesController < ApplicationController
      def create
        @postlike = PostLike.new(like_params)
        if @postlike.save
          @post = Post.find(params[:post_id])
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
        @post = Post.find(params[:post_id])
        if @user.unlike(@post)
          render json: @post, include: [
            :user,
            :architecture,
            :like_users,
            { comments: :user }
          ]
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def like_params
        params.permit(:user_id, :post_id)
      end
    end
  end
end
