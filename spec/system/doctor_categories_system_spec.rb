# frozen_string_literal: true

RSpec.describe 'Doctor Categoty stem spec', type: :system do
  let!(:admin_attrs) { { phone: '380970000000' } }
  let!(:admin) { FactoryBot.create(:user, admin_attrs) }

  before do
    driven_by(:rack_test)
    sign_in admin
  end

  context 'when sign in as admin' do
    let(:admin_attrs) { super().merge role: 'admin' }
    let!(:doctor_category) { FactoryBot.create(:doctor_category) }

    describe 'index' do
      context 'when admin visit index page' do
        before { visit admin_doctor_categories_path }

        it 'should render index page properly' do
          expect(page).to have_title 'Doctor Categories'
          expect(page).to have_selector "tr#doctor_category_#{doctor_category.id}"
        end
      end
    end

    describe 'show' do
      context 'when admin visit show page' do
        before { visit admin_doctor_category_path(doctor_category) }

        it 'should render show page properly' do
          expect(page).to have_selector '#page_title', exact_text: doctor_category.name
        end
      end
    end
  end
end
