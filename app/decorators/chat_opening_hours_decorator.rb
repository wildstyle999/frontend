class ChatOpeningHoursDecorator < Draper::Decorator
  delegate :now_open?

  def description
    if Feature.inactive?(:chat)
      I18n.t('contact_panels.web_chat.coming_soon.description_html')
    elsif now_open?
      I18n.t('contact_panels.web_chat.available.description')
    else
      I18n.t('contact_panels.web_chat.offline.description')
    end
  end

  def button_label
    if Feature.inactive?(:chat) || now_open?
      I18n.t('contact_panels.web_chat.unavailable.button')
    else
      I18n.t('contact_panels.web_chat.offline.button')
    end
  end

  def status
    now_open? ? 'open' : 'closed'
  end
end
