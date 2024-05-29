# frozen_string_literal: true

##
# The primary model used for authentication
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :phone, presence: true, uniqueness: true
  enum role: { patient: 'patient', doctor: 'doctor', admin: 'admin' }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
