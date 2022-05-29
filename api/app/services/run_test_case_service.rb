require "selenium-webdriver"

class RunTestCaseService
  def initialize(test_case_id, name)
    @name = name
    @test_case = TestCase.find(test_case_id)
    @screen = @test_case.screen
  end

  def execute!
    test_session = TestSession.create(
      name: @name,
      project_id: @screen.project_id,
      screen_id: @screen.id,
      total: 1,
      status: :running
    )

    ::RunTestCaseJob.perform_later(test_session.id, @test_case.id)
  end
end
