# encoding: utf-8
require 'pp'
require 'watir-webdriver'

# TODO: Should pull report dir (if any) from cucumber command options
REPORT_DIR = 'report'
FileUtils.mkdir_p REPORT_DIR

def filenameify(string, sep = '-')
  filename = string.downcase
  filename.gsub!(/[^a-z0-9\-_]+/, sep)
  unless sep.nil? || sep.empty?
    re_sep = Regexp.escape(sep)
    filename.gsub!(/#{re_sep}{2,}/, sep)
    filename.gsub!(/^#{re_sep}|#{re_sep}$/, '')
  end
  filename
end

def add_screenshot(name)
  filename = "#{filenameify(name)}.png"
  screenshot = @browser.screenshot
  embed screenshot.base64, 'image/png', "Screenshot"
  screenshot.save "#{REPORT_DIR}/#{filename}" # Keep on disk, as well
end

# BEFORE HOOKS will run in the same order of which they are registered.

Before do
  @context = {}
end

Before do
  @browser = @browser || (Watir::Browser.new (ENV['BROWSER'] || "phantomjs").to_sym)
  @site = @site || Site.new(@browser)
end

#  AFTER HOOKS will run in the OPPOSITE order of which they are registered.

After do # The final hook
  @site = nil
  @browser.close if @browser
end

def title_of(scenario)
  (defined? scenario.title) ? scenario.title : scenario.scenario_outline.title
end

After do |scenario|
  if scenario.failed? && @browser
    add_screenshot(title_of(scenario))
  end
end
