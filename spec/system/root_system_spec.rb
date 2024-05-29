# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root path' do
  before { driven_by(:rack_test) }

  context 'when submit empty form' do
    before { visit '/' }

    it 'should render error flash message' do
      expect(page).to have_selector 'h1', exact_text: 'Home#index'
      expect(page).to have_current_path root_path
    end
  end
end
