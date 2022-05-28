module Api
  class ElementsController < ApplicationController
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
      element.destroy!(element_params)
      render json: element
    end

    def capture_image
      service = ::CaptureImageService.new(params[:url], params[:auth_id], params[:selector_type],
                                          params[:selector_path])
      service.execute!

      render json: service.result
    end

    def element_params
      params.permit(:name, :selector_type, :selector_path, :image, :screen_id)
    end
  end
end
