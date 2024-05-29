# frozen_string_literal: true

##
# The primary model used for authentication
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :phone, presence: true, uniqueness: true
  enum role: { patient: 'patient', doctor: 'doctor', admin: 'admin' }
end
