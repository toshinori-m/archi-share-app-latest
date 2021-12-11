module Api
  module V1
    class ArchitecturesController < ApplicationController
      def index
        @architectures = Architecture.all.order(id: 'DESC')
        render json: @architectures
      end

      def show
        @architecture = Architecture.find(params[:id])
        render json: @architecture
      end

      def create
        @architecture = Architecture.new(architecture_params)
        if @architecture.save
          render json: @architecture, status: :created
        else
          render json: { message: @architecture.errors }
        end
      end

      private

      def architecture_params
        params.permit(:name, :prefecture, :address, :construction, :designer, :image, :above_floor, :under_floor)
      end
    end
  end
end
