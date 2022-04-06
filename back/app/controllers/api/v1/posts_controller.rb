module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[update destroy]

      def index
        @posts = Post.all.includes(:user, :like_users, :comments, :architecture).order(id: 'DESC')
        render json: @posts
      end

      def timeline
        @posts = Post.where(user_id: current_user.following_ids << current_user.id).order(id: 'DESC')
        render json: @posts
      end

      def show
        @post = Post.find(params[:id])
        render json: @post, include: [
          { comments: %i[user post] },
          :user,
          :architecture
        ]
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
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        render json: @post if @post.destroy
      end

      def rank
        @post_like_ranks = Post.find(PostLike.group(:post_id).order('count(post_id) desc').pluck(:post_id))
        render json: @post_like_ranks[0, 5].as_json(
          include: [:like_users]
        )
      end

      private

      def post_params
        params.permit(:title, :content, :image, :user_id, :architecture_id)
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
