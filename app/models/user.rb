# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  encrypted_password     :string           default(""), not null
#  phone                  :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("patient"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  module CONST # :nodoc:
    PETIENT_ROLE_NAME = 'parient'
    DOCTOR_ROLE_NAME = 'doctor'
    ADMIN_ROLE_NAME = 'admin'

    DEFAULT_ROLE = PETIENT_ROLE_NAME

    freeze
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :phone, presence: true, uniqueness: true
  enum role: {
    patient: CONST::DEFAULT_ROLE,
    doctor: CONST::DOCTOR_ROLE_NAME,
    admin: CONST::ADMIN_ROLE_NAME
  }, _default: CONST::DEFAULT_ROLE

  scope :doctors, -> { where(role: 'doctor') }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at encrypted_password id id_value phone remember_created_at reset_password_sent_at
       reset_password_token role updated_at]
  end
end
