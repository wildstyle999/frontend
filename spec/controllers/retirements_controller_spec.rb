RSpec.describe RetirementsController, type: :controller, features: [:pensions_and_retirement, :welsh_retirement_landing_pages] do
  describe '#index' do
    it 'responds with success' do
      get :index, locale: :en
      expect(response).to be_success
    end
  end

  describe '#locale_options' do
    subject { controller.locale_options }

    context 'index action' do
      context 'in English site' do
        before { get :index, locale: :en }
        it { is_expected.to eq(cy: '/cy/pensiynau-ac-ymddeoliad') }
      end

      context 'in Welsh site' do
        before { get :index, locale: :cy }
        it { is_expected.to eq(en: '/en/pensions-and-retirement') }
      end
    end

    context 'budgeting action' do
      context 'in English site' do
        before { get :budgeting, locale: :en }
        it { is_expected.to eq(cy: '/cy/pensiynau-ac-ymddeoliad/cyllidebu') }
      end

      context 'in Welsh site' do
        before { get :budgeting, locale: :cy }
        it { is_expected.to eq(en: '/en/pensions-and-retirement/budgeting') }
      end
    end
  end
end
