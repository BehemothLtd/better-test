require "selenium-webdriver"

class RunTestCasesService
  attr_reader :test_session_id

  def initialize(screen_id, name)
    @name = name
    @screen = Screen.find(screen_id)
    @test_cases = @screen.test_cases
  end

  def execute!
    return if @test_cases.blank?

    test_session = TestSession.create(
      name: @name,
      project_id: @screen.project_id,
      screen_id: @screen.id,
      total: @test_cases.length,
      status: :pending
    )

    @test_session_id = test_session.id

    @test_cases.each do |test_case|
      ::RunTestCaseJob.perform_later(test_session.id, test_case.id)
    end
  end
end
