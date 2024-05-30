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
#  role                   :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :phone, presence: true, uniqueness: true
  enum role: { patient: 'patient', doctor: 'doctor', admin: 'admin' }

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
