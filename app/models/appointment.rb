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
class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor, class_name: 'User'

  validates :status, presence: true

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value recommendation status updated_at user_id]
  end
end
