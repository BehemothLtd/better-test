module Api
  class TestCasesController < ApplicationController
    def index
      test_cases = Screen.find(params[:screen_id]).test_cases
      render json: test_cases
    end

    def show
      test_case_detail = Screen.find(params[:screen_id]).test_cases.find(params[:id])
      render json: test_case_detail
    end

    def create
      test_case = Screen.find(params[:screen_id]).test_cases.create!(test_case_params)
      render json: test_case
    end

    def update
      test_case = Screen.find(params[:screen_id]).test_cases.find(params[:id])
      test_case.update!(test_case_params)
      render json: test_case
    end

    def destroy
      test_case = Screen.find(params[:screen_id]).test_cases.find(params[:id])
      test_case.destroy!
      render message: "ok"
    end

    private

    def test_case_params
      params.permit(:name, :url, steps: %i[command selector_type selector_path value element_id])
    end
  end
end
