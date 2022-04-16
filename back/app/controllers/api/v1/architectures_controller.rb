module Api
  module V1
    class ArchitecturesController < ApplicationController
      def index
        @architectures = Architecture.all.order(id: 'DESC')
        render json: @architectures
      end

      def show
        @architecture = Architecture.find(params[:id])
        render json: @architecture, include: [
          { posts: %i[user like_users comments] }
        ]
      end

      def create
        @architecture = Architecture.new(architecture_params)
        if @architecture.save
          render json: @architecture, status: :created
        else
          render json: { message: @architecture.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @architecture = Architecture.find(params[:id])
        render json: @architecture if @architecture.destroy
      end

      private

      def architecture_params
        params.permit(:name, :prefecture, :address, :lat, :lng, :construction, :designer, :above_floor, :under_floor, :image)
      end
    end
  end
end
