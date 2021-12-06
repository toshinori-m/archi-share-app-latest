module Api
  module V1
    class PostLikesController < ApplicationController
      def create
        @user = User.find(params[:user_id])
        likepost = PostLike.new(like_params)
        if likepost.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:user_id])
        @post = Post.find(params[:post_id])
        likepost = @user.unlike(@post)
        if likepost.destroy
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def like_params
        params.permit(:user_id, :post_id)
      end
    end
  end
end
