class ExecuteAllScreenTestCasesJob < ApplicationJob
  queue_as :general
  sidekiq_options retry: false

  def perform(screen_id, name)
    screen = ::Screen.find(screen_id)
    test_cases = screen.test_cases
    return if test_cases.blank?

    test_session = TestSession.create(
      name: name,
      screen_id: screen_id,
      total: test_cases.length,
      status: :running
    )

    test_cases.find_each do |test_case|
      service = ::RunTestCaseService.new(test_case)
      service.execute!
      test_session.run_histories.create(
        test_case_id: test_case.id,
        result: service.result
      )

      case service.result
      when :passed
        test_session.passed_total += 1
      when :failed
        test_session.failed_total += 1
      end
    end

    test_session.status = :finished
    test_session.save
  end
end
