RSpec.describe CarCampaignsController, :type => :controller do
  describe 'GET show' do
    before { allow(CarCampaign).to receive(:new) { double } }
    context 'when id is whitelisted' do
      let(:whitelisted_id) { 'revealed-the-true-cost-of-buying-a-car' }

      it 'is successful' do
        get :show, locale: I18n.locale, id: whitelisted_id

        expect(response).to be_ok
      end
    end
  end
end
