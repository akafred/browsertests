# encoding: UTF-8

Given(/^I am on the DuckDuckGo front page$/) do
  @site.DuckDuckGo.visit
end

When(/^I search for "([^"]*)" without being tracked$/) do |search_term|
  @context[:search_term] = search_term
  @site.DuckDuckGo.search(@context[:search_term])
end

Then(/^I should find it in the results without being tracked$/) do
  @site.DuckDuckGoResult.page_text.should include(@context[:search_term])
end


