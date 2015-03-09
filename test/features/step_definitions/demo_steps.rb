# encoding: UTF-8

Given(/^I am on the koha front page$/) do
  @browser.goto 'http://catalog.bywatersolutions.com/'
end

When(/^I search for "([^"]*)"$/) do |search_term|
  @context[:search_term] = search_term
  form = @browser.form(:id => 'searchform')
  form.text_field(:name => 'q').set @context[:search_term]
  # binding.pry   # uncomment and see what happens!
  form.submit
end

Then(/^I should find it in the results$/) do
  @browser.div(:id => 'userresults').text.should include(@context[:search_term])
end