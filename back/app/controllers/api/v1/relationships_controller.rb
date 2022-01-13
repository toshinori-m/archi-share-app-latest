module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        user = @user.follow(@follow)
        render json: user, status: :created
      end

      def destroy
        if @user.unfollow(@follow)
          render json: @user, status: :ok
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
