module Api
  class ElementsController < ApplicationController
    def capture_image
      service = ::CaptureImageService.new(params[:url], params[:auth_id], params[:selector])
      service.execute!

      render json: service.result
    end
  end
end
