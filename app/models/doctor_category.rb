# frozen_string_literal: true

# == Schema Information
#
# Table name: doctor_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_doctor_categories_on_name  (name) UNIQUE
#
class DoctorCategory < ApplicationRecord
  validates :name, uniqueness: true
end
