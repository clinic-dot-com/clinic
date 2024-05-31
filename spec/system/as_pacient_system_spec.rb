# frozen_string_literal: true

describe 'Sign in as Patient' do
  let!(:patient_attrs) { { phone: '1111', role: :patient } }
  let!(:patient) { FactoryBot.create(:user, patient_attrs) }

  before do
    driven_by(:rack_test)
    sign_in patient
  end

  context 'when visit "/admin/dashboard"' do
    before { visit '/admin/dashboard' }

    it 'should render Dashboard page' do
      expect(page).to have_selector '#page_title', text: 'Dashboard'
    end
  end

  describe 'Appointments menu item is NOT present' do
    before { visit '/admin/dashboard' }

    it 'should render Appointments menu item' do
      within('.header') do
        expect(page).not_to have_link 'Appointments'
      end
    end
  end

  context 'when create appointment' do
    subject { click_button 'Submit' }

    let!(:doctor) { FactoryBot.create(:user, role: :doctor, phone: '888888') }

    before do
      visit '/admin/dashboard'
      click_link 'Create Appointment'
      select doctor.display_name, from: 'Doctor'
    end

    it 'should create new appointment and redirect to dashboard with green flash message' do
      expect { subject }.to change(Appointment.where(doctor:, user: patient), :count).by(1)
      expect(page).to have_selector '.flash', exact_text: 'The appointment was successfully created'
    end
  end

  context 'destroy appointment' do
    subject { click_link 'Delete' }

    let!(:doctor) { FactoryBot.create(:user, role: :doctor, phone: '888888') }
    let!(:appointment) { FactoryBot.create(:appointment, doctor:, user: patient, recommendation: 'string') }

    before do
      visit '/admin/dashboard'
    end

    it 'should render appointment assigned to current patient' do
      expect { subject }.to change(Appointment, :count).by(-1)
      expect(page).to have_selector '.flash', exact_text: 'The Appointment was successfully destroyd.'
      expect(page).to have_current_path admin_dashboard_path
    end
  end
end
