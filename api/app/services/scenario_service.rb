require "selenium-webdriver"
require "json"

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
      case step["command"]
      when "open"
        @driver.get(step["selector_path"])
      when "click"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        @driver.execute_script("arguments[0].scrollIntoView(true);", el)
        sleep(0.5)
        el.click
      when "type"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        el.send_keys(step["value"])
      when "wait"
        if step["selector_type"].present? && step["selector_path"]
          @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        else
          sleep(step["value"].to_i)
        end
      end
    end
  end
end
