require 'spec_helper'

RSpec.describe CarCampaign do
  let(:id) { 'test-id' }

  subject(:car_campaign) { described_class.new(id) }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:intro) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:call_to_action) }
  it { is_expected.to respond_to(:intro_html)}
  it { is_expected.to respond_to(:articles)}

  describe '#canonical_url' do
    let(:url) { '/test_url' }
    before do
      allow_any_instance_of(Rails.application.routes.url_helpers).to receive(:car_campaign_path) { url }
    end

    it 'returns the canonical_url' do
      expect(car_campaign.canonical_url).to eq(url)
    end
  end

  describe '#alternate_options' do
    let(:cy_url) { '/cy_url' }

    before do
      allow(I18n).to receive(:t).
        with("car_campaigns.#{id}.alternates") { [{ id: 'test-id', hreflang: :cy }] }

      allow_any_instance_of(Rails.application.routes.url_helpers).to receive(:car_campaign_path) { cy_url }
    end

    it 'returns the alternates map' do
      expect(car_campaign.alternate_options).to eq({ cy: cy_url })
    end
  end
end
