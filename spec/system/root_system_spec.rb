# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root path' do
  before { driven_by(:rack_test) }

  context 'when visit "/" path' do
    before { visit '/' }

    it 'should render home controller' do
      expect(page).to have_selector 'h1', exact_text: 'Home#index'
      expect(page).to have_current_path root_path
    end

    it 'should display additional info about build' do
      expect(page).to have_selector '.build-info', text: 'Build information: version:'
      expect(page).to have_link 'Status page', href: 'https://clinic.betteruptime.com'
    end
  end
end
