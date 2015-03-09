# encoding: utf-8

require_relative 'page_root.rb'

class DuckDuckGoResult < PageRoot
  def page_text
    @browser.text
  end
end