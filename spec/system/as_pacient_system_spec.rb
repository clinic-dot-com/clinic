# frozen_string_literal: true

describe 'Sign in as Pacient' do
  let!(:admin_attrs) { { phone: '1111', role: :pacient } }
  let!(:admin) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    sign_in admin
  end

  context 'when visit "/admin/dashboard"' do
    before { visit '/admin/dashboard' }

    it 'should render Dashboard page' do
      expect(page).to have_selector '#page_title', text: 'Dashboard'
    end
  end

  describe 'Appointments menu item is present' do
    before { visit '/admin/dashboard' }

    it 'should render Appointments menu item' do
      within('.header') do
        expect(page).to have_link 'Appointments'
      end
    end
  end

  context 'when visit Appointment index page' do
    before { visit '/admin/appointments' }

    it 'should render Appointments index page properly' do
      expect(page).to have_link 'New Appointment'
      expect(page).to have_selector '.blank_slate', text: 'There are no Appointments yet.'
    end
  end
end
