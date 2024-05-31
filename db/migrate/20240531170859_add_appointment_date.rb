# frozen_string_literal: true

class AddAppointmentDate < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :appointment_date, :date
  end
end
