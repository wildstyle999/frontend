When(/^I visit the news page in (.*)$/) do |language|
  locale = language_to_locale(language)
  news_page.load(locale: locale)
end

When(/^I visit the news page$/) do
  step 'I visit the news page in English'
end

When(/^I visit the last news page$/) do
  news_page.load(locale: 'en', page_number: '53')
end
