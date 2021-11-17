module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.find(params[:id])
        render json: @user.as_json(only: %i[id name email introduction image])
      end
    end
  end
end
