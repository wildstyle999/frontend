RSpec.describe NewsArticleDecorator do

  subject(:decorator) { described_class.decorate(news_article) }

  let(:news_article) { Core::NewsArticle.new('news_article_id', attributes) }
  let(:attributes) { {} }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:intro) }

  describe '#content' do
    let(:attributes) { { body: '<p>Body content</><p><em>Photo: PA</em></p>' } }

    let(:html) { Nokogiri::HTML(decorator.content) }

    it 'removes the image author paragraph' do
      expect(html.search(HTMLProcessor::IMAGE_AUTHOR)).to be_empty
    end

    it 'does not remove quoted phrases' do
      expect(html.search('//p/em')).to_not be_empty
    end
  end

  describe '#intro' do
    let(:intro) { 'This is the intro' }
    let(:attributes) { { body: "<p class=\'intro\'>#{intro}</p><p>Other content</p>" } }

    it 'returns the intro paragraph' do
      expect(decorator.intro).to eq(intro)
    end
  end

  describe '#path' do
    before { allow(helpers).to receive_messages(news_article_path: '/news/test') }

    it 'returns the path to the news article' do
      expect(subject.path).to eq('/news/test')
    end
  end

end
