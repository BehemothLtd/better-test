module Api
  class TestSessionsController < ApplicationController
    def index
      test_sessions = TestSession.all

      test_sessions = TestSession.all.where(screen_id: params[:screen_id]) unless params[:screen_id].blank?
      test_sessions = TestSession.all.where(project_id: params[:project_id]) unless params[:project_id].blank?
      render json: test_sessions
    end

    def show
      run_histories = TestSession.find(params[:id]).run_histories

      render json: run_histories, each_serializer: RunHistorySerializer
    end
  end
end
