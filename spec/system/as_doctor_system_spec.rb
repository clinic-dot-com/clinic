# frozen_string_literal: true

RSpec.describe 'Signed as Doctor User' do
  let(:doctor_attrs) { { role: :doctor, phone: '888888' } }
  let!(:doctor) { FactoryBot.create(:user, doctor_attrs) }

  before do
    sign_in doctor
  end

  context 'when doctor have one appointment without recommendation' do
    let!(:patient) { FactoryBot.create(:user, role: :patient, phone: '111111') }
    let!(:appointment) { FactoryBot.create(:appointment, user_id: patient.id, doctor:, recommendation: nil) }

    context 'when visit dashboard' do
      before do
        driven_by(:rack_test)
        visit '/admin/dashboard'
      end

      it 'link should be visible' do
        expect(page).to have_link 'Leave recommendation'
      end
    end

    context 'when click to "leave recommendation" link and then submit modal' do
      before do
        driven_by(:selenium_chrome_headless)
        visit '/admin/dashboard'
      end

      it 'should leave recommendation' do
        click_link 'Leave recommendation'
        fill_in 'recommendation', with: 'string'
        click_button :OK
        expect(page).to have_selector '.flash', exact_text: 'The recommendation was successfully created'
        expect(appointment.reload).to have_attributes(recommendation: 'string')
      end
    end
  end

  context 'when doctor do NOT have any appointments' do
    before do
      driven_by :rack_test
      visit '/admin/dashboard'
    end

    it 'should render default empty message' do
      expect(page).to have_current_path '/admin/dashboard'
      expect(page).to have_selector '.blank_slate', exact_text: 'There is no any Appointment assigned to you'
    end
  end

  context 'when visit index page of Doctor Categories' do
    let!(:doctor_category) { FactoryBot.create(:doctor_category, name: 'default cat') }

    before do
      driven_by :rack_test
      visit '/admin/dashboard'
      click_link 'Doctor Categories'
    end

    it 'should render index page properly' do
      expect(page).to have_selector 'h2', exact_text: 'Doctor Categories'
      expect(page).to have_link 'New Doctor Category'
      expect(page).to have_content 'default cat'
    end
  end

  context 'when doctor do not have category and try to change them' do
    let!(:doctor_category) { FactoryBot.create(:doctor_category, name: 'Dentist') }

    it 'should change category' do
      driven_by :selenium_chrome_headless
      visit '/admin/dashboard'
      click_link 'Change Category'
      select 'Dentist', from: 'Doctor category'
      click_button :OK

      expect(page).to have_selector '.flash', exact_text: 'The categoty was successfully changed'
      expect(page).to have_selector '#current_user', text: "Doctor | ##{doctor.id} | 888888 | Dentist"
    end
  end
end
