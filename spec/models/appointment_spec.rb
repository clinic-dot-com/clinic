# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id               :bigint           not null, primary key
#  appointment_date :date
#  recommendation   :text
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  doctor_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_appointments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Appointment do
  describe '.save!' do
    subject { record.save! }

    let!(:doctor) { FactoryBot.create(:user, role: :doctor) }
    let!(:patient) { FactoryBot.create(:user, role: :patient, phone: '111111') }
    let(:record) { FactoryBot.build(:appointment, doctor:, user: patient) }

    it 'should create new Appointment' do
      expect { subject }.to change(described_class, :count).by(1)
    end
  end
end
