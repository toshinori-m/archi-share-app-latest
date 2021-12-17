module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[update destroy]

      def index
        @posts = Post.all.includes(:user, :like_users, :architecture).order(id: 'DESC')
        render json: @posts.as_json(
          only: %i[id title content image created_at],
          include: [
            { user: { only: %i[id name image] } },
            :like_users,
            :architecture
          ]
        )
      end

      def show
        @post = Post.includes(:like_users, :architecture, :comments).find(params[:id])
        render json: @post.as_json(
          only: %i[id title content image],
          include: [
            { user: { only: %i[id name image] } },
            { comments: { include: [
              { user: { only: %i[id name image] } },
              { post: { only: %i[id] } }
            ] } },
            :like_users,
            :architecture
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

      def update
        if @post.update(post_params)
          render json: @post.as_json(
            include: [:user]
          )
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @post.destroy
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.permit(:user_id, :title, :content, :image, :architecture_id)
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
