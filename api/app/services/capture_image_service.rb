require "selenium-webdriver"

class CaptureImageService
  attr_reader :result

  PATH = Rails.root.join("public/images")

  def initialize(url, scenario_id, selector_type, selector_path)
    @url = url
    @scenario = Scenario.find_by(id: scenario_id)
    @selector_type = selector_type
    @selector_path = selector_path
    initialize_driver
  end

  def execute!
    if @scenario.present?
      service = ::ScenarioService.new(@driver, @scenario)
      service.execute!
    end

    @driver.navigate.to @url
    wait = Selenium::WebDriver::Wait.new(timeout: 10)

    ele = wait.until { @driver.find_element(@selector_type, @selector_path) }
    path = "images/#{SecureRandom.alphanumeric(8)}.jpg"
    full_path = Rails.root.join("public/#{path}")
    ele = ele.find_element(:xpath, "./..") if %w[input select].include?(ele.tag_name)
    sleep(0.5)
    ele.save_screenshot(full_path)
    @result = { url: "#{ENV['API_HOST']}/#{path}" }
  ensure
    @driver&.quit
  end

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

    @driver = Selenium::WebDriver.for :chrome, http_client: client, options: options
  end
end
