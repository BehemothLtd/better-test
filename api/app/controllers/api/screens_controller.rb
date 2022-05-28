module Api
  class ScreensController < ApplicationController

    def show
      screen = Screen.find(params[:id])
      elements = screen.elements
      render json: screen.serializable_hash.merge(elements: elements)
    end

    def create
        screen = Screen.create(screen_params)
        render json: screen
    end

    def update
      screen = Screen.find(params[:id])
      screen.update(screen_params)
      render json: screen
      end

    def destroy
      screen = Screen.find(params[:id])
      screen.destroy!
      render json: screen
    end

    def screen_params
      params.permit(:name, :project_id, :url, :auth_id)
    end
  end
end