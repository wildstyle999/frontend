Given(/^chat is online$/) do
  Timecop.travel(Chronic.parse('Tuesday 2pm'))

  home_page.load(locale: :en)
end

Given(/^an advisor is available$/) do
  true
end

Given(/^all advisors are busy$/) do
  pending
end

Given(/^chat will be next online later today$/) do
  Timecop.travel(Chronic.parse('Tuesday 5am'))

  home_page.load(locale: :en)
end

Given(/^chat will be next online tomorrow$/) do
  Timecop.travel(Chronic.parse('Tuesday 11pm'))

  home_page.load(locale: :en)
end

When(/^I visit the website in Welsh$/) do
  home_page.load(locale: :cy)
end

Then(/^I should be able to start a chat with an advisor$/) do
  expect(home_page.chat.button).
    to have_content(I18n.t('contact_panels.web_chat.available.button'))

  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.web_chat.available.description'))
end

Then(/^I should not be able to start a chat with an advisor$/) do
  expect(home_page.chat.button).
    to have_content(I18n.t('contact_panels.web_chat.offline.button'))

  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.web_chat.offline.description'))
end

Then(/^I should see a message informing me that I need JavaScript in order chat with an advisor$/) do
  expect(home_page.chat).to have_javascript_warning
end

Then(/^I should see a message informing me that chat is currently busy$/) do
  pending
end

Then(/^I should see a message informing me that chat will be online between today's opening hours$/) do
  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.web_chat.offline.description'))
end

Then(/^I should see a message informing me that chat will be online tomorrow with tomorrow's opening hours$/) do
  expect(home_page.chat.description).
    to have_content(I18n.t('contact_panels.web_chat.offline.description'))
end

Then(/^I should see a message informing me that chat is only available in English$/) do
  expect(home_page.chat).to have_welsh_warning
end
