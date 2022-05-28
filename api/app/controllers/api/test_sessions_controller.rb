module Api
  class TestSessionsController < ApplicationController
    def index
      test_sessions = Screen.find(params[:screen_id]).test_sessions
      render json: test_sessions
    end

    def show
      run_histories = Screen.find(params[:screen_id]).test_sessions.find(params[:id]).run_histories

      render json: run_histories, each_serializer: RunHistorySerializer
    end
  end
end
