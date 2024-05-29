# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign In' do
  before { driven_by(:rack_test) }

  context 'when visit "/users/sign_in" path' do
    before { visit new_user_session_path }

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
      expect(page).to have_current_path new_user_session_path
    end
  end
end
