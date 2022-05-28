module Api
  class ProjectsController < ApplicationController
    # protect_from_forgery with: :null_session

    def index
      render json: Project.all
    end

    def show
      project = Project.find(params[:id]).screens
      render json: project
    end
  end
end
