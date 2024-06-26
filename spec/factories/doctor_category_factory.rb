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
FactoryBot.define do
  factory :doctor_category, class: 'DoctorCategory' do
    name { 'Random name' }
  end
end
