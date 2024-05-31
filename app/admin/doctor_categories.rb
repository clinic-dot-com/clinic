# frozen_string_literal: true

ActiveAdmin.register DoctorCategory do
  permit_params :name

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end

    panel 'Assigned Doctors' do
      table_for resource.doctors do
        column :id
        column 'Display name' do |row|
          auto_link row
        end
      end
    end
  end
end
