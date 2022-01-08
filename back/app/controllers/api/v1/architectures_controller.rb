module Api
  module V1
    class ArchitecturesController < ApplicationController
      def index
        @architectures = Architecture.all.order(id: 'DESC')
        render json: @architectures
      end

      def show
        @architecture = Architecture.includes(:posts).find(params[:id])
        render json: @architecture.as_json(
          include: [
            { posts: { include: [
              { user: { only: %i[id name image] } },
              :like_users
            ] } }
          ]
        )
      end

      def create
        @architecture = Architecture.new(architecture_params)
        if @architecture.save
          render json: @architecture, status: :created
        else
          render json: { message: @architecture.errors }
        end
      end

      def destroy
        @architecture = Architecture.find(params[:id])
        if @architecture.destroy
          render json: @architecture
        else
          render json: @architecture.errors, status: :unprocessable_entity
        end
      end

      private

      def architecture_params
        params.permit(:name, :prefecture, :address, :lat, :lng, :construction, :designer, :image, :above_floor, :under_floor)
      end
    end
  end
end
