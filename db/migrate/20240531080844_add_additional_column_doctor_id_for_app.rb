# frozen_string_literal: true

class AddAdditionalColumnDoctorIdForApp < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointments, :doctor, foreign_key: { to_table: :users }, index: false
  end
end
