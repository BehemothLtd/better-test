require "selenium-webdriver"
require "json"

class ScenarioService
  attr_reader :result, :message, :index, :images

  def initialize(driver, test_case)
    @driver = driver
    @driver_wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @test_case = test_case
    @index = 0
    @images = []
  end

  def execute!
    steps = @test_case.steps
    @driver.get(@test_case.url)

    steps.each_with_index do |step, index|
      @index = index
      Rails.logger.info step
      case step["command"]
      when "open"
        @driver.get(step["value"])
      when "click"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        @driver.execute_script("arguments[0].scrollIntoView(true);", el)
        sleep(0.5)
        el.click
      when "input"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        el.send_keys(step["value"])
      when "scenario"
        el = Scenario.find(step["value"])
        service = ScenarioService.new(@driver, el)
        service.execute!
        if service.result == :failed
          @result = :failed
          @message = "Step #{index}: Scenario #{el.name} failed"
          @images += service.images
          break
        end
      when "wait"
        if step["selector_type"].present? && step["selector_path"]
          @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        else
          sleep(step["value"].to_i)
        end
      when "assert"
        el = @driver_wait.until { @driver.find_element(step["selector_type"], step["selector_path"]) }
        if el.text != step["value"]
          @result = :failed
          @message = "Step #{index}: Assert failed"
          break
        end
      end

      path = "images/#{SecureRandom.alphanumeric(8)}.jpg"
      full_path = Rails.root.join("public/#{path}")
      @driver.find_element(tag_name: "body").save_screenshot(full_path)
      @images << {
        step: index + 1,
        image: "#{ENV['API_HOST']}/#{path}"
      }
    end

    @result = :passed
  rescue StandardError => e
    @message = "Step #{@index}: #{e.message}"
    @result = :failed
  end
end
