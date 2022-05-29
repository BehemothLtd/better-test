class RunTestCaseJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(test_session_id, test_case_id)
    test_session = ::TestSession.find(test_session_id)
    test_case = ::TestCase.find(test_case_id)
    screen = ::Screen.find(test_case.screen_id)

    @driver = initialize_driver

    test_session.update(status: :running)
    history = test_session.run_histories.create(
      test_case_id: test_case.id,
      result: :pending
    )

    if screen.pre_script.present?
      begin
        service = ::ScenarioService.new(@driver, screen.pre_script)
        service.execute!
        raise "failed" if service.result == :failed
      rescue StandardError
        test_session.status = :pre_script_failed
        test_session.save
        return
      end
    end

    service = ::ScenarioService.new(@driver, test_case)
    service.execute!

    history.update(
      result: service.result,
      message: service.message
    )

    case service.result
    when :passed
      test_session.passed_total += 1
    when :failed
      test_session.failed_total += 1
    end

    test_session.status = :finished if test_session.passed_total + test_session.failed_total == test_session.total
    test_session.save
  ensure
    @driver&.quit
  end

  private

  def initialize_driver
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--window-size=1400,4000")
    options.add_argument("--disable-gpu")
    options.add_argument("--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36")
    options.add_argument("--hide-scrollbars")
    options.add_argument("--ignore-certificate-errors")
    options.add_argument("--single-process")
    options.add_argument("--disable-desktop-notifications")
    options.add_argument("--disable-extensions")
    options.add_argument("--disable-plugins")
    options.add_argument("--disable-java")
    options.add_argument("--disable-dev-shm-usage")

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 10_000

    Selenium::WebDriver.for :chrome, http_client: client, options: options
  end
end
