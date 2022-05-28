module Api
  class ScreensController < ApplicationController

    def show
      screen = Screen.find(params[:id])
      render json: screen
    end

    def create
      begin
        screen = Screen.create(screen_params)
        render json: screen
      rescue ActiveRecord::RecordNotUnique
        render message: "Record already exists"
      end
    end

    def update
      screen = Screen.find(params[:id])
      begin
        screen.update(screen_params)
        render message "Updated"
      rescue ActiveRecord::RecordNotUnique
        render message: "Record already exists"
      end
    end

    def destroy
      screen = Screen.find(params[:id])
      if screen.destroy
        render message "Destroyed"
      else
        render message "Can't destroy"
      end
    end

    def screen_params
      params.permit(:name, :project_id, :url, :auth_id)
    end
  end
end
