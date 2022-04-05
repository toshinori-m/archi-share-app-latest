module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @comment = Comment.new(comment_params)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment = Comment.find(params[:id])
        render json: @comment if @comment.destroy
      end

      private

      def comment_params
        params.permit(:content, :user_id, :post_id)
      end
    end
  end
end
