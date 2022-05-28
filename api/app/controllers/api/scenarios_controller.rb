module Api
  class ScenariosController < ApplicationController
    def index
      render json: Scenario.all
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
      params.permit(:name, :project_id, steps: %i[command selector_path selector_type value])
    end
  end
end
