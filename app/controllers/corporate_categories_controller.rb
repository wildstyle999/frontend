class CorporateCategoriesController < CategoriesController
  decorates_assigned :category, with: CorporateCategoryDecorator
  decorates_assigned :article, with: ContentItemDecorator

  before_action :paywall_debt_advice_evaluation_toolkit

  def show
    super

    set_article
    @corporate_category = Core::CategoryReader.new('corporate-home').call
    assign_active_categories(@corporate_category)
  end

  private

  def paywall_debt_advice_evaluation_toolkit
    if params[:id] == 'debt-advice-evaluation-toolkit' && session[:agreement_token].blank?
      redirect_to "/#{I18n.locale}/agreements/debt_evaluation_toolkit/new"
    end
  end

  def article_interactor
    Core::CorporateReader.new(default_article_id)
  end

  def set_article
    @article = article_interactor.call
  rescue
    # TODO change this in the cms repository to return nil on 404
    @article = nil
  end

  def default_article_id
    category.contents.first.id
  end
end
