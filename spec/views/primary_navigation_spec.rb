require 'spec_helper'

describe 'primary navigation' do
  let(:categories) do [
    double(id: id, title: '', description: '', sub_categories: [])
  ] end

  before do
    render 'shared/primary_nav.html.erb', category_navigation: categories
  end

  context 'when rendering a non-news category' do
    let(:id) { 'my-category' }

    it 'links to the category page' do
      expect(rendered).to include %{href="/#{I18n.locale}/categories/#{id}"}
    end
  end

  context 'when rendering the news category' do
    let(:id) { 'news' }

    it 'links to the news section' do
      expect(rendered).to include %{href="/#{I18n.locale}/news"}
    end
  end
end