module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        user = @user.follow(@follow)
        render json: user, status: :created
      end

      def destroy
        user = @user.unfollow(@follow)
        if user.destroy
          render json: user, status: :ok
        else
          render status: :unprocessable_entity
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
