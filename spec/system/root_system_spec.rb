require 'rails_helper'

RSpec.describe "Root path", type: :system do
  before { driven_by(:rack_test) }

  context 'when visit root path' do
    before { visit '/' }

    it 'should render sign in form' do
      expect(page).to have_selector 'h2', exact_text: 'Log in'
      expect(page).to have_field 'Phone', type: :tel
      expect(page).to have_field 'Password', type: :password
      expect(page).to have_unchecked_field 'Remember me'
      expect(page).to have_button 'Log in'
      expect(page).to have_link 'Sign up', href: new_user_registration_path
      expect(page).to have_link 'Forgot your password?', href: new_user_password_path
      expect(page).to have_link count: 2
      expect(page).to have_field count: 3
      expect(page).to have_current_path root_path
    end
  end

  context 'when submit empty form' do
    subject { click_button 'Log in' }

    before { visit '/' }

    it 'should render error flash message' do
      subject
      expect(page).to have_selector '.alert', exact_text: 'Invalid Email or password.'
      expect(page).to have_current_path new_user_session_path
    end
  end
end
