class CarCampaign
  include Rails.application.routes.url_helpers

  attr_accessor :id, :translatable
  private :translatable

  def initialize(id)
    self.id = id
  end

  def title(section = '')
    I18n.t("car_campaigns.#{id}.#{section}.title")
  end

  def intro_html
    I18n.t("car_campaigns.#{id}.intro_html").html_safe
  end

  def intro(section = '')
    I18n.t("car_campaigns.#{id}.#{section}.intro")
  end

  def description
    I18n.t("car_campaigns.#{id}.description")
  end

  def articles(section)
    I18n.t("car_campaigns.#{id}.#{section}.articles")
  end

  def call_to_action
    button_text = I18n.t("car_campaigns.#{id}.car_costs_calculator_button_content")
    ActionController::Base.helpers.link_to(
      button_text, tool_path(id: 'car-costs-calculator', locale: I18n.locale), class: "button button--primary")
  end

  def canonical_url
    car_campaign_path(id: id, locale: I18n.locale)
  end

  def alternate_options
    alternates = I18n.t("car_campaigns.#{id}.alternates")

    alternates.each_with_object({}) do |alternate, hash|
      hash[alternate[:hreflang]] =
        car_campaign_path(id: alternate[:id], locale: alternate[:hreflang])
    end
  end
end
