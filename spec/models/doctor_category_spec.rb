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
RSpec.describe DoctorCategory do
  describe '.save!' do
    subject { record.save! }

    let(:record_attrs) { { name: 'dentist' } }
    let!(:record) { FactoryBot.build(:doctor_category, record_attrs) }

    it 'should create table in DB' do
      expect { subject }.to change(described_class, :count).by(1)
    end
  end

  describe '.create!' do
    subject { described_class.create!(record_attrs) }

    let(:record_attrs) { { name: 'dentist' } }

    it 'should create table in DB' do
      expect { subject }.to change(described_class, :count).by(1)
    end
  end
end
