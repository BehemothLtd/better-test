module Api
  class ProjectsController < ApplicationController
    # protect_from_forgery with: :null_session

    def index
      render json: Project.all
    end
  end
end
