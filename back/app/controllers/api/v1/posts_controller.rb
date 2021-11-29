module Api
  module V1
    class PostsController < ApplicationController
      def show
        @post = Post.find(params[:id])
        render json: @post.as_json(
          only: %i[id title content image],
          include: [
            user: { only: %i[id name image] }
          ]
        )
      end

      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.permit(:user_id, :title, :content, :image)
      end
    end
  end
end
