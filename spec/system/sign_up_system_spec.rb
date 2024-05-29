require 'rails_helper'

RSpec.describe 'Sign Up' do
  before { driven_by(:rack_test) }

  context 'when visit "/users/sign_up" page' do
    before { visit new_user_registration_path }

    it 'should render registration form' do
      expect(page).to have_selector 'h2', exact_text: 'Sign up'
      expect(page).to have_field 'Phone', type: :tel
      expect(page).to have_field 'Password', type: :password
      expect(page).to have_field 'Password confirmation', type: :password
      expect(page).to have_button 'Sign up'
      expect(page).to have_link 'Log in'
      expect(page).to have_select 'Role'
      expect(page).to have_link count: 1
      expect(page).to have_field count: 4
    end
  end

  context 'when submit empty form' do
    subject { click_button 'Sign up' }

    before { visit new_user_registration_path }

    it 'should render error flash message' do
      subject
      expect(page).to have_selector '.alert', exact_text: ''
    end
  end

  context 'when submit valid fields' do
    subject { click_button 'Sign up' }

    before { visit new_user_registration_path }

    it 'should render error flash message' do
      fill_in 'Phone', with: '18649201111'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      select 'patient', from: 'Role'
      subject
      expect(page).to have_selector '.notice', exact_text: 'Welcome! You have signed up successfully.'
    end
  end
end
