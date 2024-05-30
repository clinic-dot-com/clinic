# frozen_string_literal: true

RSpec.describe 'Doctor system spec', type: :system do
  let!(:admin_attrs) { { phone: '380970000000' } }
  let!(:admin) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    sign_in admin
  end

  context 'when sign in as admin' do
    let(:admin_attrs) { super().merge role: 'admin' }

    describe 'index' do
      context 'when admin visit index page' do
        let!(:doctor) { FactoryBot.create(:user, role: 'doctor', phone: '380978888888') }

        before { visit admin_doctors_path }

        it 'should render index page properly' do
          expect(page).to have_title 'Doctors'
          expect(page).to have_selector "tr#user_#{doctor.id}"
        end
      end
    end

    describe 'show' do
      context 'when admin visit show page' do
        let!(:doctor) { FactoryBot.create(:user, role: 'doctor', phone: '380978888888') }

        before { visit admin_doctor_path(doctor) }

        it 'should render index page properly' do
          expect(page).to have_selector '#page_title', exact_text: "User ##{doctor.id}"
        end
      end
    end
  end
end
