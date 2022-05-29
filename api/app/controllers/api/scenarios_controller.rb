module Api
  class ScenariosController < ApplicationController
    def index
      scenarios = Scenario.all
      scenarios.where(project_id: params[:project_id]) if params[:project_id]
      render json: scenarios
    end

    def show
      render json: Scenario.find(params[:id])
    end

    def create
      scenario = Scenario.create!(scenario_params)
      render json: scenario
    end

    def update
      scenario = Scenario.find(params[:id])
      scenario.update!(scenario_params)
      render json: scenario
    end

    def destroy
      scenario = Scenario.find(params[:id])
      scenario.destroy!
      render json: scenario
    end

    private

    def scenario_params
      params.permit(:name, :url, :project_id, steps: %i[command selector_path selector_type value element_id])
    end
  end
end
