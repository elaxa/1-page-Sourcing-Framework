require 'rubygems'
ENV['TAZA_ENV'] ||= 'qa'
ENV['BROWSER']  ||= 'firefox' #phantomjs
ENV['HEADLESS'] ||= 'headless'
TAZA_ROOT=File.join(File.dirname(__FILE__), '../')
require 'watir-webdriver'
require 'watir-dom-wait'
require 'rspec'
require 'taza'
#require 'mocha'
require 'headless'
require 'phantomjs'
require 'allure-rspec'
require 'nokogiri'
require 'uuid'


lib_path = File.expand_path("#{File.dirname(__FILE__)}/../lib/")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
lib_root = File.expand_path("File.dirname(__FILE__)}/../lib")

require "#{TAZA_ROOT}/lib/sites/sourcing"
require "#{TAZA_ROOT}/lib/sites/sourcing"


Dir[File.join(TAZA_ROOT, "spec/support/**/*.rb")].each {|f| require f }
HTML_REPORT_FOLDER = 'reports'
SCREENS_FOLDER = HTML_REPORT_FOLDER + '/screens'
ALLURE_REPORTS = HTML_REPORT_FOLDER + '/allure'

RSpec.configure do |config|
  include Taza::Fixtures::Sourcing

  config.mock_with :mocha
  config.color = true                                         # Use color in STDOUT
  config.tty = true                                           # Use color not only in STDOUT but also in pagers and files
  config.formatter = :documentation                           # :progress, :html, :textmate # Use the specified formatter
  #config.infer_spec_type_from_file_location!
  config.include AllureRSpec::Adaptor
  #config.fail_fast = true
  config.before(:all) do

    reports
    @root = "#{Dir.pwd}"
    @download_dir = "#{Dir.pwd}/downloads"

    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.download.folderList'] = 2 #custom location
    profile['browser.download.dir'] = @download_dir
    profile['browser.download.manager.showWhenStarting'] = false
    profile['browser.helperApps.alwaysAsk.force'] = false
    profile['browser.helperApps.neverAsk.openFile'] = "application/octet-stream, application/pdf"
    profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream, application/pdf"
    profile['pdfjs.disabled'] = true

    #Headless.new(display: 100, reuse: true, destroy_at_exit: false).start
    @sourcing_url  = Taza::Settings.site_file('sourcing')
    browser   =  Watir::Browser.new ENV['BROWSER'].to_sym, :profile => profile
    @sourcing = Sourcing.new(:browser => browser)
    @sourcing.browser.driver.manage.window.maximize
  end

  config.after(:each) do |example|
    if  @sourcing.browser.exists?
      if !example.exception.nil?
        take_screenshot(example, 'fail_screenshot')
      else
        take_screenshot(example,'success_screenshot')
      end
    end
  end

  config.after(:all) do
    @sourcing.browser.close
  end
end

AllureRSpec.configure do |c|
  c.output_dir = ALLURE_REPORTS
end


def timestamp
  time_formated = Time.now.to_i.to_s.reverse.chop.chop.chop.reverse.to_i
  return time_formated.to_s
end

def reports
  FileUtils.mkdir_p(HTML_REPORT_FOLDER) unless File.exist?(HTML_REPORT_FOLDER)
  FileUtils.mkdir_p(SCREENS_FOLDER) unless File.exist?(SCREENS_FOLDER)
end

def one_page_initiate
  browser =  Watir::Browser.new ENV['BROWSER'].to_sym
  one_page = Sourcing.new(:browser => browser)
  one_page.browser.driver.manage.window.maximize
  one_page
end

def take_screenshot(s, title)
  screenshot_file = ALLURE_REPORTS + "/#{Time.now.to_i}.png"
  if @sourcing.browser.windows.size.equal? 2 then use_last end
  file = @sourcing.browser.screenshot.save screenshot_file
  puts "Screenshot: #{screenshot_file}"
  s.attach_file title, file
end

def use_last
  sleep 2
  @sourcing.browser.windows.last.use
end

def close_last
  @sourcing.browser.windows.last.close
  sleep 2
end

#Method closes all of the opened firefox browsers. Disable during debugging.
def kill_foxes
  Sys::ProcTable.ps.each do |ps|
    if ps.comm.downcase =~ /firefox/
      Process.kill('KILL',ps.pid)
    end
  end
end

