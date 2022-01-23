module Api
  module V1
    class PostLikesController < ApplicationController
      def create
        likepost = PostLike.new(like_params)
        if likepost.save
          @post = Post.find(params[:post_id])
          render json: @post.as_json(
            only: %i[id title content image],
            include: [
              { user: { only: %i[id name image] } },
              :like_users,
              :comments,
              :architecture
            ]
          ), status: :created
        else
          render json: likepost.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:user_id])
        @post = Post.find(params[:post_id])
        if @user.unlike(@post)
          render json: @post.as_json(
            only: %i[id title content image],
            include: [
              { user: { only: %i[id name image] } },
              :like_users,
              :comments,
              :architecture
            ]
          )
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
