module Api
  class ScreensController < ApplicationController
    def index
      screens = Screen.all
      screens = screens.where(project_id: params[:project_id]) if params[:project_id]
      render json: screens
    end

    def show
      screen = Screen.find(params[:id])
      elements = screen.elements
      pre_script = screen.pre_script
      render json: screen.serializable_hash.merge(elements: elements, pre_script: pre_script)
    end

    def create
      screen = Screen.create(create_screen_params)
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

    def run_test_cases
      service = ::RunTestCasesService.new(params[:id], params[:name])
      service.execute!
      render json: { test_session_id: service.test_session_id }
    end

    def screen_params
      params.permit(:name, :project_id, :url, :pre_script_id)
    end

    def create_screen_params
      params.permit(:name, :project_id, :url, :pre_script_id,
                    elements_attributes: %i[name selector_type selector_path image])
    end
  end
end
