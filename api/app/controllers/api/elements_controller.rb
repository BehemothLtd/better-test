module Api
  class ElementsController < ApplicationController
    def index
      elements = Element.all
      render json: elements
    end

    def create
      element = Element.create!(element_params)
      render json: element
    end

    def update
      element = Element.find(params[:id])
      element.update!(element_params)
      render json: element
    end

    def destroy
      element = Element.find(params[:id])
      element.destroy!
      render json: element
    end

    def capture_image
      service = ::CaptureImageService.new(
        params[:url],
        params[:scenario_id],
        params[:selector_type],
        params[:selector_path]
      )
      service.execute!

      render json: service.result
    end

    def element_params
      params.permit(:name, :selector_type, :selector_path, :image, :screen_id)
    end
  end
end
