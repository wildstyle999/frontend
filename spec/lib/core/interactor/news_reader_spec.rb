require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe NewsReader do
    subject(:news_reader) { described_class.new(page) }

    let(:page) { nil }
    let(:public_website) { double }

    before do
      allow(Registry::Repository).to receive(:[]).with(:news) do
        double(all: data)
      end

      allow(public_website).to receive(:all).and_return(data)
      allow(Registry::Repository).to receive(:[]).with(:news).and_return(public_website)
    end

    describe '#call' do
      subject(:news) { news_reader.call }

      context 'when the repository returns no data' do
        let(:data) { nil }

        it { is_expected.to be_a(NewsCollection) }

        it 'is empty collection' do
          expect(subject).to be_empty
        end
      end

      context 'when the repository returns data' do

        let(:data) do
          [{
            'id'    => 'news-article-id',
            'title' => 'The title',
            'body'  => 'the body',
            'date'  => '23/09/2011'
          }]
        end

        it { is_expected.to be_a(NewsCollection) }

        specify 'colection items are news article entities' do
          expect(news.first).to be_a(NewsArticle)
        end
      end
    end
  end
end