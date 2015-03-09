# encoding: utf-8

require 'rspec'

class PageRoot
  include RSpec::Matchers

  def initialize(site)
    @site = site
    @browser = site.browser
  end
end