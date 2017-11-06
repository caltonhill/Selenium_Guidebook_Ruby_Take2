require 'selenium-webdriver'

RSpec.configure do |config|

  config.before(:each) do |example|
    case ENV['host']
      when 'saucelabs'
        caps = Selenium::WebDriver::Remote::Capabilities.send(ENV['browser'])
        caps.version = ENV['browser_version']
        caps.platform = ENV['operating_system']
        caps[:name] = example.metadata[:full_description]

        @driver = Selenium::WebDriver.for(
                     :remote,
                     url: "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub",
                     desired_capabilities: caps)
      else
          case ENV['browser']
          when 'chrome'
            chromedriver = '..\tools\chromedriver.exe'
            @driver = Selenium::WebDriver.for :chrome, driver_path: chromedriver
          when 'firefox'
            geckodriver = '..\tools\geckodriver.exe'
            @driver = Selenium::WebDriver.for :firefox, driver_path: geckodriver
          when 'internet_explorer'
            ie_driver = '..\tools\IEDriverServer.exe'
            @driver = Selenium::WebDriver.for :internet_explorer, driver_path: ie_driver
          end
      end
  end

  config.after(:each) do |example|
    begin
    if ENV['host'] == 'saucelabs'
      if example.exception.nil?
        SauceWhisk::Jobs.pass_job @driver.session_id
      else
        SauceWhisk::Jobs.fail_job @driver.session_id
        raise "Watch video of the test at https://saucelabs.com/tests/#{@driver.session_id}"
      end
    end
  ensure
      @driver.quit
    end
  end

end

