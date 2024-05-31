# frozen_string_literal: true

class AddDoctorCatToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :doctor_category, foreign_key: { to_table: :doctor_categories }, index: false
  end
end
