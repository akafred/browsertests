# encoding: utf-8

require_relative 'page_root.rb'

class DuckDuckGo < PageRoot
  def visit
    @browser.goto "http://www.duckduckgo.com/"
    self
  end

  def search(search_term)
    form = @browser.form(:id => "search_form_homepage")
    form.text_field(:id => "search_form_input_homepage").set search_term
    form.submit
    @site.DuckDuckGoResult
  end
end