# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id             :bigint           not null, primary key
#  recommendation :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_appointments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Appointment do
  describe '.save!' do
    subject { record.save! }

    let(:record) { FactoryBot.build(:appointment) }

    it 'should create new Appointment' do
      expect { subject }.to change(described_class, :count).by(1)
    end
  end
end
