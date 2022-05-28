require 'selenium-webdriver'
require 'json'

class ScenarioService
  def initialize(driver, test_case)
    @driver = driver
    @driver_wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @test_case = test_case
  end

  def execute!
    steps = @test_case.steps
    @driver.get(@test_case.url)

    steps.each do |step|
      Rails.logger.info step
      if step["command"] == "open"
        @driver.get(step["selector_path"])
      elsif step["command"] == "click"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        @driver.execute_script("arguments[0].scrollIntoView(true);", el)
        sleep(0.5)
        el.click
      elsif step["command"] == "type"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        el.send_keys(step["value"])
      end
    end
  rescue StandardError => e
    @result = e
  ensure
    @driver&.quit
  end
end
