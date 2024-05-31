# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id             :bigint           not null, primary key
#  recommendation :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  doctor_id      :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_appointments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :appointment, class: 'Appointment' do
    user { association(:user) }
    status { 'MyString' }
    recommendation { 'MyText' }
  end
end
