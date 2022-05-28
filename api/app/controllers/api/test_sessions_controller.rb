module Api
  class TestSessionsController < ApplicationController
    def index
      test_sessions = TestSession.all

      test_sessions = TestSession.all.where(screen_id: params[:screen_id]) if params[:screen_id]
      test_sessions = TestSession.all.where(project_id: params[:project_id]) if params[:project_id]
      render json: test_sessions
    end

    def show
      run_histories = TestSession.find(params[:id]).run_histories

      render json: run_histories, each_serializer: RunHistorySerializer
    end
  end
end
