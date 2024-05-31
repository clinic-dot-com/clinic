# frozen_string_literal: true

class AddDefaultDoctorAndPatient < ActiveRecord::Migration[7.1]
  def up
    Doctor.create(phone: '888888', password: '888888', password_confirmation: '888888', role: :doctor)
    Patient.create(phone: '111111', password: '111111', password_confirmation: '111111', role: :patient)
  end

  def down
    Doctor.delete_by(phone: '888888')
    Patient.delete_by(phone: '111111')
  end
end
