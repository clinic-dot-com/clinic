# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root path' do
  before { driven_by(:rack_test) }

  context 'when visit "/" path' do
    before { visit '/' }

    it 'should render home controller' do
      expect(page).to have_selector 'h1', exact_text: 'Welcome to clinic management system'
      expect(page).to have_selector 'h3', exact_text: 'the most popular clinic in Ukrainer'
      expect(page).to have_current_path root_path
    end
  end
end
