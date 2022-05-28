module Api
  class ProjectsController < ApplicationController
    # protect_from_forgery with: :null_session

    def index
      render json: Project.all
    end

    def show
      project = Project.find(params[:id])
      render json: {
        screens: project.screens,
        scenarios: project.scenarios
      }
    end
  end
end
