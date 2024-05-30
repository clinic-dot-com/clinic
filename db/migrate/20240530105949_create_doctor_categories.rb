# frozen_string_literal: true

class CreateDoctorCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_categories do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
