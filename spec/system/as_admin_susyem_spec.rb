# frozen_string_literal: true

RSpec.describe 'Signed as Admin', type: :system do
  let!(:admin_attrs) { { phone: '380970000000', role: :admin } }
  let!(:admin) { FactoryBot.create(:user, admin_attrs) }

  before do
    driven_by(:rack_test)
    sign_in admin
  end

  context 'when visit index page of doctors' do
    let!(:doctor) { FactoryBot.create(:user, role: 'doctor', phone: '380978888888') }

    before { visit admin_doctors_path }

    it 'should render index page properly' do
      expect(page).to have_title 'Doctors'
      expect(page).to have_selector "tr#doctor_#{doctor.id}"
    end
  end

  context 'when visit show page of doctors' do
    let!(:doctor) { FactoryBot.create(:user, role: 'doctor', phone: '380978888888') }

    before { visit admin_doctor_path(doctor) }

    it 'should render index page properly' do
      expect(page).to have_selector '#page_title', exact_text: doctor.display_name
    end
  end
end
