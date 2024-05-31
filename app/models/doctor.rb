# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  encrypted_password     :string           default(""), not null
#  phone                  :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("patient"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  doctor_category_id     :bigint
#
# Indexes
#
#  index_users_on_phone                 (phone) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (doctor_category_id => doctor_categories.id)
#
class Doctor < User
  def self.ransackable_associations(_auth_object = nil)
    %w[doctor_category appointments]
  end

  has_many :appointments, class_name: 'Appointment', dependent: :destroy
end
