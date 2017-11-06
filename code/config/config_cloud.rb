require 'sauce_whisk'

ENV['base_url']           ||= 'http://the-internet.herokuapp.com'
ENV['host']                 = 'saucelabs'
ENV['SAUCE_USERNAME']      = 'temp_SL'
ENV['SAUCE_ACCESS_KEY']    = '66ec775e-b34d-48b3-8cc7-c74a8f2f82ba'
ENV['operating_system']   ||= 'Windows 10'
ENV['browser']            ||= 'chrome'
ENV['browser_version']    ||= '60'