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

  context 'when visit show page of Patients' do
    let!(:patient) { FactoryBot.create(:user, role: 'patient', phone: '111111') }

    before { visit admin_patient_path(patient) }

    it 'should render index page properly' do
      expect(page).to have_selector '#page_title', exact_text: patient.display_name
    end
  end

  context 'when admin from index page of doctors page change its category' do
    subject { click_button :OK }

    let(:doctor_attrs) { { role: 'doctor', phone: '380978888888', doctor_category: nil } }
    let!(:doctor) { FactoryBot.create(:user, doctor_attrs) }
    let!(:doctor_category) { FactoryBot.create(:doctor_category) }

    before do
      driven_by(:selenium_chrome_headless)
      visit admin_doctors_path
      click_link 'Change Category'
      within('#dialog_confirm') { select doctor_category.name, from: 'Doctor category' }
    end

    it 'should change category' do
      expect { subject }.to change { doctor.reload.doctor_category }.from(nil).to(doctor_category)
      expect(page).to have_selector '.flash', text: 'The categoty was successfully changed'
    end
  end

  context 'when visit show page of doctor categoty' do
    let!(:doctor_category) { FactoryBot.create(:doctor_category) }
    let(:doctor_attrs) { { role: 'doctor', phone: '380978888888', doctor_category: } }
    let!(:doctor) { FactoryBot.create(:user, doctor_attrs) }

    before do
      visit admin_doctor_category_path(doctor_category)
    end

    it 'should render show page of specific Doctor Category' do
      expect(page).to have_selector 'h2', text: doctor_category.name
      expect(page).to have_content 'Assigned Doctors'
      expect(page).to have_content '380978888888'
    end
  end
end
